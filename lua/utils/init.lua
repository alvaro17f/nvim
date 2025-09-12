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
  return nil
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

M.require_safe = function(module)
  local ok, result = pcall(require, module)
  return ok and result or nil
end

local process_path = function(path)
  if path and not path:match("/lua/") then
    return vim.fn.stdpath("config") .. "/lua/" .. path:gsub("^/", ""):gsub("/?$", "/")
  end
  if path then
    return path:gsub("/?$", "/")
  end
  local source = debug.getinfo(3, "S").source:sub(2)
  local modules_path = source:match("(.*/)")
  return modules_path and modules_path:gsub("/?$", "/") or ""
end

M.require_modules = function(path, process_fn)
  if type(process_fn) ~= "function" then
    process_fn = function(...) end
  end

  local modules_path = process_path(path)
  local success, files = pcall(vim.fn.readdir, modules_path)
  if not success then
    return
  end

  local _, lua_end = modules_path:find(".*/lua/")
  local module_prefix = lua_end and modules_path:sub(lua_end + 1):gsub("/$", ""):gsub("/", ".") or ""

  for _, module in pairs(files) do
    if module:match("%.lua$") and not module:match("init.lua$") then
      local module_name = (module_prefix ~= "" and module_prefix .. "." or "") .. module:gsub("%.lua$", "")
      local ok, result = pcall(require, module_name)
      if ok and result and type(result) == "table" then
        process_fn(result, module_name)
      else
        local file_path = modules_path .. module
        local load_ok, load_result = pcall(loadfile, file_path)
        if load_ok and load_result then
          local module_result = load_result()
          if type(module_result) == "table" then
            process_fn(module_result, file_path)
          end
        end
      end
    end
  end
end

M.get_config = function(path)
  local config = {}
  M.require_modules(path, function(module_result)
    if module_result.config then
      M.deep_merge(config, module_result.config)
    end
  end)
  return config
end

return M
