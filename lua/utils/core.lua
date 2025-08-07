local M = {}

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
      table.insert(modules, require("plugins." .. folder_name .. "." .. module:gsub("%.lua$", "")))
    end
  end

  return modules
end

function M.require_safe(module)
  local ok, result = pcall(require, module)
  return ok and result or nil
end

return M
