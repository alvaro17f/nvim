local M = {}

local DEFAULT_FLAGS = {
  copilot = false,
}

local function capitalize_first_letter(str)
  return str:sub(1, 1):upper() .. str:sub(2)
end

local flags_path = vim.fn.stdpath("data") .. "/flags"

local function read_flags(file)
  local flags = {}
  local f = io.open(file, "r")
  if f then
    for line in f:lines() do
      for k, v in string.gmatch(line, "(%w+)%s*=%s*(%w+)") do
        if v == "true" then
          flags[k] = true
        elseif v == "false" then
          flags[k] = false
        end
      end
    end
    f:close()
  end
  return flags
end

local function write_flags(file, flags)
  local f = io.open(file, "w")
  if f then
    for k, v in pairs(flags) do
      f:write(string.format("%s = %s\n", k, tostring(v)))
    end
    f:close()
  end
end

function M.get_flags(flag_to_check)
  local flags = {}
  if vim.fn.filereadable(flags_path) == 1 then
    flags = read_flags(flags_path)
  end

  if flags[flag_to_check] == nil then
    if DEFAULT_FLAGS[flag_to_check] ~= nil then
      flags[flag_to_check] = DEFAULT_FLAGS[flag_to_check]
    else
      flags[flag_to_check] = false
    end
    write_flags(flags_path, flags)
  end

  return flags[flag_to_check]
end

function M.set_flags(flag, value)
  local flags = {}
  if vim.fn.filereadable(flags_path) == 1 then
    flags = read_flags(flags_path)
  end
  flags[flag] = value
  write_flags(flags_path, flags)
end

local function get_all_flags()
  local flags = {}
  if vim.fn.filereadable(flags_path) == 1 then
    flags = read_flags(flags_path)
  end

  for k, v in pairs(DEFAULT_FLAGS) do
    if flags[k] == nil then
      flags[k] = v
    end
  end

  return flags
end

function M.generate_flags_fn()
  local function create_flag_command(flag)
    vim.api.nvim_create_user_command("Flags" .. capitalize_first_letter(flag) .. "Enable", function()
      set_flags(flag, true)
      vim.notify(flag .. " enabled", vim.log.levels.INFO)
    end, {})

    vim.api.nvim_create_user_command("Flags" .. capitalize_first_letter(flag) .. "Disable", function()
      set_flags(flag, false)
      vim.notify(flag .. " disabled", vim.log.levels.INFO)
    end, {})
  end

  local all_flags = get_all_flags()
  for flag, _ in pairs(all_flags) do
    create_flag_command(flag)
  end
end

return M
