local M = {}

M.color = function(group, prop)
  prop = prop or "fg"
  group = type(group) == "table" and group or { group }
  for _, g in ipairs(group) do
    local hl = vim.api.nvim_get_hl(0, { name = g, link = false })
    if hl[prop] then
      return string.format("#%06x", hl[prop])
    end
  end
end

M.deep_merge = function(target, source)
  for k, v in pairs(source) do
    if type(v) == "table" and type(target[k]) == "table" then
      M.deep_merge(target[k], v)
    else
      target[k] = v
    end
  end
end

local load_module_files = function(path, process_fn)
  local modules_path = path or debug.getinfo(2, "S").source:sub(2):match("(.*/)")
  local success, files = pcall(vim.fn.readdir, modules_path)
  if not success then
    return
  end

  for _, module in pairs(files) do
    if module:match("%.lua$") and not module:match("init.lua$") then
      local file_path = modules_path .. module
      local ok, result = pcall(loadfile, file_path)
      if ok and result then
        local module_result = result()
        if type(module_result) == "table" then
          process_fn(module_result, file_path)
        end
      end
    end
  end
end

M.get_config = function(path)
  local modules = {}
  load_module_files(path, function(module_result)
    if module_result.config then
      M.deep_merge(modules, module_result.config)
    end
  end)
  return modules
end

M.load_keymaps = function(path)
  load_module_files(path, function(_) end)
end

M.require_safe = function(module)
  local ok, result = pcall(require, module)
  return ok and result or nil
end

M.require_modules = function(path, recursive)
  local modules_path

  if path and not path:match("/lua/") then
    modules_path = vim.fn.stdpath("config") .. "/lua/" .. path:gsub("^/", "")
  else
    modules_path = path or debug.getinfo(2, "S").source:sub(2):match("(.*/)")
  end

  modules_path = modules_path:gsub("/?$", "/")

  recursive = recursive or true

  local module_prefix = ""
  local _, lua_end = modules_path:find(".*/lua/")
  if lua_end then
    module_prefix = modules_path:sub(lua_end + 1):gsub("/$", ""):gsub("/", ".")
  end

  local function require_recursive(dir_path, sub_prefix)
    local success, files = pcall(vim.fn.readdir, dir_path)
    if not success then
      return
    end

    for _, item in pairs(files) do
      local full_path = dir_path .. item
      local stat = vim.loop.fs_stat(full_path)
      if stat and stat.type == "directory" and recursive then
        require_recursive(full_path .. "/", sub_prefix .. item .. ".")
      elseif item:match("%.lua$") and not item:match("init.lua$") then
        local module_name = (module_prefix ~= "" and module_prefix .. "." or "")
          .. sub_prefix
          .. item:gsub("%.lua$", "")
        require(module_name)
      end
    end
  end

  require_recursive(modules_path, "")
end

return M
