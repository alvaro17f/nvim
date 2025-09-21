_G.Utils = _G.Utils or {}

---@param group string|string[] hl group to get color from
---@param prop? string property to get. Defaults to "fg"
Utils.color = function(group, prop)
  prop = prop or "fg"
  group = type(group) == "table" and group or { group }
  ---@cast group string[]
  for _, g in ipairs(group) do
    local hl = vim.api.nvim_get_hl(0, { name = g, link = false })
    if hl[prop] then
      return string.format("#%06x", hl[prop])
    end
  end
end

---@param target table
---@param source table
Utils.deep_merge = function(target, source)
  for k, v in pairs(source) do
    if type(v) == "table" and type(target[k]) == "table" then
      Utils.deep_merge(target[k], v)
    else
      target[k] = v
    end
  end
end

---@param module string
Utils.require_safe = function(module)
  local ok, result = pcall(require, module)
  return ok and result or nil
end

---@param path? string
local process_path = function(path)
  if path and not path:match("/lua/") then
    return vim.fn.stdpath("config") .. "/lua/" .. path:gsub("^/", ""):gsub("/?$", "/")
  end
  if path then
    return path:gsub("/?$", "/")
  end
  local source = debug.getinfo(3, "S").source:sub(2)
  local modules_path = source:match("(.*/)")
  return modules_path and modules_path:gsub("/?$", "/") or "./"
end

---@param path string
---@param load? {early?: string[], after?: string[]}
Utils.require_inits = function(path, load)
  local modules_path = process_path(path)
  if modules_path == "" then
    local source = debug.getinfo(2, "S").source:sub(2)
    modules_path = source:match("(.*/)") or "./"
  end

  local _, lua_end = modules_path:find(".*/lua/")
  local module_prefix = lua_end and modules_path:sub(lua_end + 1):gsub("/$", ""):gsub("/", ".") or ""

  load = load or {}
  local early = load.early or {}
  local after = load.after or {}

  local early_set = {}
  local after_set = {}
  local modules = { early = {}, normal = {}, after = {} }

  for _, fname in ipairs(early) do
    local full_module_name = module_prefix .. (module_prefix ~= "" and "." or "") .. fname
    early_set[full_module_name] = true
    table.insert(modules.early, full_module_name)
  end

  for _, fname in ipairs(after) do
    local full_module_name = module_prefix .. (module_prefix ~= "" and "." or "") .. fname
    after_set[full_module_name] = true
    table.insert(modules.after, full_module_name)
  end

  local init_files = vim.fn.globpath(modules_path, "**/init.lua", false, true)
  for _, file in ipairs(init_files) do
    local rel = file:sub(#modules_path + 1):gsub("/init%.lua$", "")
    local module_name = rel:gsub("/", ".")
    if module_prefix ~= "" and module_name ~= "" then
      module_name = module_prefix .. "." .. module_name
    elseif module_prefix ~= "" and module_name == "" then
      module_name = module_prefix
    end

    if module_name ~= "" then
      if not early_set[module_name] and not after_set[module_name] then
        table.insert(modules.normal, module_name)
      end
    end
  end

  for _, category in ipairs({ "early", "normal", "after" }) do
    for _, module_name in ipairs(modules[category]) do
      local ok, err = pcall(require, module_name)
      if not ok then
        local msg = string.format("[init] Failed to load %s '%s': %s", category, module_name, err)
        vim.notify(msg, vim.log.levels.WARN)
      end
    end
  end
end

---@param path? string
---@param process_fn? function
Utils.require_modules = function(path, process_fn)
  if type(process_fn) ~= "function" then
    process_fn = function(...) end
  end

  local modules_path = process_path(path)
  local lua_files = vim.fn.globpath(modules_path, "**/*.lua", false, true)
  local _, lua_end = modules_path:find(".*/lua/")
  local module_prefix = lua_end and modules_path:sub(lua_end + 1):gsub("/$", ""):gsub("/", ".") or ""

  for _, file in ipairs(lua_files) do
    if not file:match("/init%.lua$") then
      local rel_path = file:sub(#modules_path + 1)
      local module_name = rel_path:gsub("%.lua$", ""):gsub("/", ".")

      if module_prefix ~= "" then
        module_name = module_prefix .. "." .. module_name
      end

      local ok, result = pcall(require, module_name)
      if ok and result and type(result) == "table" then
        process_fn(result, module_name)
      end
    end
  end
end

---@param path? string
Utils.get_config = function(path)
  local config = {}
  Utils.require_modules(path, function(module_result)
    if module_result.config then
      Utils.deep_merge(config, module_result.config)
    end
  end)
  return config
end

---------------------
-- REQUIRE UTILS
---------------------
Utils.require_modules()
