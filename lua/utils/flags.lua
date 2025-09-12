local M = {}

local default_flags = {}
local show_icons = false
local flags_path = vim.fn.stdpath("data") .. "/flags"

local read_file = function(file)
  local f, err = io.open(file, "r")
  if not f then
    vim.notify("Error opening file: " .. err, vim.log.levels.ERROR)
    return nil
  end
  return f
end

local write_file = function(file, content)
  local f, err = io.open(file, "w")
  if not f then
    vim.notify("Error opening file: " .. err, vim.log.levels.ERROR)
    return false
  end
  f:write(content)
  f:close()
  return true
end

local read_flags = function(file)
  local flags = {}
  local f = read_file(file)
  if not f then
    return flags
  end

  for line in f:lines() do
    for k, v in string.gmatch(line, '([^%s=]+)%s*=%s*"?([^"\n]*)"?') do
      v = v:match('^"?(.*)"?$') or v
      if v == "true" then
        flags[k] = true
      elseif v == "false" then
        flags[k] = false
      elseif v:match("^%d+$") then
        flags[k] = tonumber(v)
      else
        flags[k] = v
      end
    end
  end
  f:close()
  return flags
end

local write_flags = function(file, flags)
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

local clean_flags = function(file)
  local flags = read_flags(file)
  for k in pairs(flags) do
    if default_flags[k] == nil then
      flags[k] = nil
    end
  end
  write_flags(file, flags)
end

---@param flag_to_check string
M.get_flags = function(flag_to_check)
  local flags = vim.fn.filereadable(flags_path) == 1 and read_flags(flags_path) or {}
  if flags[flag_to_check] == nil then
    flags[flag_to_check] = default_flags[flag_to_check] or false
    write_flags(flags_path, flags)
  end
  return flags[flag_to_check]
end

local set_flags = function(flag, value)
  local flags = vim.fn.filereadable(flags_path) == 1 and read_flags(flags_path) or {}
  flags[flag] = value
  write_flags(flags_path, flags)
end

local get_all_flags = function()
  local flags = vim.fn.filereadable(flags_path) == 1 and read_flags(flags_path) or {}
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

local format_label = function(flag, value)
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
  }

  (type_handlers[type(value)] or type_handlers.default)()

  return label
end

M.toggle = function()
  clean_flags(flags_path)

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
      M.toggle()
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
          M.toggle()
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

local generate_flags_fn = function()
  vim.api.nvim_create_user_command("Flags", M.toggle, {})
end

---@param opts {flags: table, icons: boolean, path?: string}
M.setup = function(opts)
  default_flags = opts.flags or {}
  flags_path = opts.path or flags_path
  show_icons = opts.icons or false
  generate_flags_fn()
end

---@param path string
---@param extra_opts? table
M.get_options_by_path = function(path, extra_opts)
  local options = {}

  local success, files = pcall(vim.fn.readdir, path)
  if not success then
    return options
  end

  for _, option in pairs(files) do
    if option:match("init.lua$") then
      goto continue
    elseif option:match("%.lua$") then
      option = option:gsub("%.lua$", "")
    end

    table.insert(options, option)

    ::continue::
  end

  if extra_opts then
    vim.list_extend(options, extra_opts)
  end

  return options
end

return M
