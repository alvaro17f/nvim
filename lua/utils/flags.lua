local M = {}

local default_flags = {}
local show_icons = false
local path = vim.fn.stdpath("data") .. "/flags"

local function read_file(file)
  local f, err = io.open(file, "r")
  if not f then
    vim.notify("Error opening file: " .. err, vim.log.levels.ERROR)
    return nil
  end
  return f
end

local function write_file(file, content)
  local f, err = io.open(file, "w")
  if not f then
    vim.notify("Error opening file: " .. err, vim.log.levels.ERROR)
    return false
  end
  f:write(content)
  f:close()
  return true
end

local function read_flags(file)
  local flags = {}
  local f = read_file(file)
  if not f then
    return flags
  end

  for line in f:lines() do
    for k, v in string.gmatch(line, '(%w+)%s*=%s*"?(%w+)"?') do
      if v == "true" then
        flags[k] = true
      elseif v == "false" then
        flags[k] = false
      else
        flags[k] = v
      end
    end
  end
  f:close()
  return flags
end

local function write_flags(file, flags)
  local type_handlers = {
    boolean = function(k, v)
      return string.format("%s = %s\n", k, tostring(v))
    end,
    string = function(k, v)
      return string.format('%s = "%s"\n', k, v)
    end,
    table = function(k, v)
      return string.format('%s = "%s"\n', k, v.default)
    end,
  }

  for k, v in pairs(default_flags) do
    if flags[k] == nil then
      flags[k] = v
    end
  end

  local content = ""
  local sorted_keys = {}
  for k in pairs(flags) do
    table.insert(sorted_keys, k)
  end
  table.sort(sorted_keys)

  for _, k in ipairs(sorted_keys) do
    local v = flags[k]
    local handler = type_handlers[type(v)]
    if handler then
      content = content .. handler(k, v)
    end
  end

  return write_file(file, content)
end

local function clean_flags(file)
  local flags = read_flags(file)
  for k in pairs(flags) do
    if default_flags[k] == nil then
      flags[k] = nil
    end
  end
  write_flags(file, flags)
end

function M.get_flags(flag_to_check)
  local flags = vim.fn.filereadable(path) == 1 and read_flags(path) or {}
  if flags[flag_to_check] == nil then
    flags[flag_to_check] = default_flags[flag_to_check] or false
    write_flags(path, flags)
  end
  return flags[flag_to_check]
end

local function set_flags(flag, value)
  local flags = vim.fn.filereadable(path) == 1 and read_flags(path) or {}
  flags[flag] = value
  write_flags(path, flags)
end

local function get_all_flags()
  local flags = vim.fn.filereadable(path) == 1 and read_flags(path) or {}
  for k, v in pairs(default_flags) do
    if flags[k] == nil then
      if type(v) == "table" and v.default then
        flags[k] = v.default
      else
        flags[k] = v
      end
    end
  end
  return flags
end

local function format_label(flag, value)
  local icon = (value == true and " ") or (value == false and " ") or " "
  local label = show_icons and (icon .. " " .. flag) or flag

  local type_handlers = {
    boolean = function()
      if not show_icons then
        label = label .. " (" .. (value and "enabled" or "disabled") .. ")"
      end
    end,
    default = function()
      label = label .. " (" .. tostring(value) .. ")"
    end,
  };

  (type_handlers[type(value)] or type_handlers.default)()

  return label
end

local function toggle_flags_ui()
  clean_flags(path)

  local items = {}

  for flag, value in pairs(get_all_flags()) do
    local label = format_label(flag, value)
    table.insert(items, { label = label, flag = flag, value = value })
  end

  table.sort(items, function(a, b)
    return a.flag < b.flag
  end)

  local type_handlers = {
    boolean = function(choice)
      local new_value = not choice.value
      set_flags(choice.flag, new_value)
      vim.notify(choice.flag .. " " .. (new_value and "enabled" or "disabled"), vim.log.levels.INFO)
      toggle_flags_ui()
    end,
    table = function(choice)
      local options = default_flags[choice.flag].options
      if type(options[1]) == "boolean" then
        options = { true, false }
      end
      vim.ui.select(options, {
        prompt = "Select a value for: [" .. choice.flag .. "]",
        format_item = function(item)
          return tostring(item)
        end,
      }, function(selected)
        if selected ~= nil then
          set_flags(choice.flag, selected)
          vim.notify(choice.flag .. " set to " .. tostring(selected), vim.log.levels.INFO)
          toggle_flags_ui()
        end
      end)
    end,
  }

  vim.ui.select(items, {
    prompt = "Select a flag to toggle or set:",
    format_item = function(item)
      return item.label
    end,
  }, function(choice)
    if choice then
      local handler = type_handlers[type(default_flags[choice.flag])]
      if handler then
        handler(choice)
      end
    end
  end)
end

local function generate_flags_fn()
  vim.api.nvim_create_user_command("Flags", function()
    toggle_flags_ui()
  end, {})
end

local function setup_keymaps(keys)
  for _, key in ipairs(keys) do
    vim.api.nvim_set_keymap(key.mode, key.lhs, key.rhs, key.opts or {})
  end
end

function M.setup(opts)
  default_flags = opts.flags or {}
  path = opts.path or path
  show_icons = opts.icons or false
  if opts.keys then
    setup_keymaps(opts.keys)
  end
  generate_flags_fn()
end

return M
