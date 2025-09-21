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

--- Function to require all modules in a given directory.
---
--- Default values:
--- ```yaml
---   path: caller's source path
---   load: {}
---   process_fn: function(...) end
---   init_files_lookup: false
--- ```
---@param opts? {path?: string, load?: {early?: string[], after?: string[]}, process_fn?: function, init_files_lookup?: boolean}
Utils.require = function(opts)
  opts = opts or {}
  local path = opts.path
  local load = opts.load or {}
  local process_fn = opts.process_fn or function(...) end
  local init_files_lookup = opts.init_files_lookup or false

  if opts.path ~= nil and type(opts.path) ~= "string" then
    vim.notify("[Utils.require] path must be a string", vim.log.levels.ERROR)
    return
  end

  local modules_path = process_path(path)
  local _, lua_end = modules_path:find(".*/lua/")
  local module_prefix = lua_end and modules_path:sub(lua_end + 1):gsub("/$", ""):gsub("/", ".") or ""

  local early_set, after_set = {}, {}
  local modules = { early = {}, normal = {}, after = {} }

  local function process_module_list(list, set, category)
    for _, fname in ipairs(list or {}) do
      local name = module_prefix .. (module_prefix ~= "" and "." or "") .. fname
      set[name] = true
      table.insert(modules[category], name)
    end
  end

  process_module_list(load.early, early_set, "early")
  process_module_list(load.after, after_set, "after")

  local files = vim.fn.globpath(modules_path, init_files_lookup and "**/init.lua" or "**/*.lua", false, true)

  for _, file in ipairs(files) do
    local is_init_file = file:match("/init%.lua$")

    if (init_files_lookup and not is_init_file) or (not init_files_lookup and is_init_file) then
      goto continue
    end

    local rel_path = file:sub(#modules_path + 1)
    if is_init_file then
      rel_path = rel_path:gsub("/init%.lua$", "")
    else
      rel_path = rel_path:gsub("%.lua$", "")
    end

    local module_name = rel_path:gsub("/", ".")
    if module_prefix ~= "" and module_name ~= "" then
      module_name = module_prefix .. "." .. module_name
    elseif module_prefix ~= "" and module_name == "" then
      module_name = module_prefix
    end

    if module_name ~= "" and not early_set[module_name] and not after_set[module_name] then
      table.insert(modules.normal, module_name)
    end

    ::continue::
  end

  for _, category in ipairs({ "early", "normal", "after" }) do
    for _, module_name in ipairs(modules[category]) do
      local ok, result = pcall(require, module_name)
      if not ok then
        vim.notify(
          string.format("[Utils.require] Failed to load %s '%s': %s", category, module_name, result),
          vim.log.levels.WARN
        )
      elseif not init_files_lookup and result and type(result) == "table" then
        process_fn(result, module_name)
      end
    end
  end
end

---@param path? string
Utils.get_config = function(path)
  local config = {}
  Utils.require({
    path = path,
    process_fn = function(module_result)
      if module_result.config then
        Utils.deep_merge(config, module_result.config)
      end
    end,
  })
  return config
end

---------------------
-- REQUIRE UTILS
---------------------
Utils.require()
