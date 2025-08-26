local M = {}

function M.deep_merge(target, source)
  for k, v in pairs(source) do
    if type(v) == "table" and type(target[k]) == "table" then
      M.deep_merge(target[k], v)
    else
      target[k] = v
    end
  end
end

local function load_module_files(path, process_fn)
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

function M.get_config(path)
  local modules = {}
  load_module_files(path, function(module_result)
    if module_result.config then
      M.deep_merge(modules, module_result.config)
    end
  end)
  return modules
end

function M.load_keymaps(path)
  load_module_files(path, function(_) end)
end

function M.update_plugins()
  local all_plugins = vim.pack.get()
  vim.pack.update(all_plugins[#all_plugins + 1], { force = true })
end

function M.require_safe(module)
  local ok, result = pcall(require, module)
  return ok and result or nil
end

function M.require_modules(path)
  local modules = {}
  local modules_path = path or debug.getinfo(2, "S").source:sub(2):match("(.*/)")
  local folder_name = modules_path:match("([^/]+)/?$")

  local success, files = pcall(vim.fn.readdir, modules_path)
  if not success then
    return modules
  end

  for _, module in pairs(files) do
    if module:match("%.lua$") and not module:match("init.lua$") then
      require("plugins." .. folder_name .. "." .. module:gsub("%.lua$", ""))
    end
  end
end

return M
