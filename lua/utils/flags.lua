local DEFAULT_FLAGS = {
  copilot = false,
}

local flags_path = vim.fn.stdpath("data") .. "/flags"

local function read_flags(file)
  local flags = {}
  local file = io.open(file, "r")
  if file then
    for line in file:lines() do
      for k, v in string.gmatch(line, "(%w+)%s*=%s*(%w+)") do
        if v == "true" then
          flags[k] = true
        elseif v == "false" then
          flags[k] = false
        end
      end
    end
    file:close()
  end
  return flags
end

local function write_flags(file, flags)
  local f = io.open(file, "w")
  for k, v in pairs(flags) do
    f:write(string.format("%s = %s\n", k, tostring(v)))
  end
  f:close()
end

local function get_flags(flag_to_check)
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

local function set_flags(flag, value)
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

return {
  get_flags = get_flags,
  set_flags = set_flags,
  get_all_flags = get_all_flags,
}
