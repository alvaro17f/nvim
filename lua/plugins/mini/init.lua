local plugins = {}

local files = vim.fn.readdir(vim.fn.stdpath("config") .. "/lua/plugins/mini/")
local lua_files = {}
for _, file in ipairs(files) do
  if file:match("%.lua$") then
    table.insert(lua_files, file)
  end
end

for _, file in ipairs(lua_files) do
  if file ~= "init.lua" then
    table.insert(plugins, require("plugins.mini." .. file:gsub("%.lua$", "")))
  end
end

return plugins
