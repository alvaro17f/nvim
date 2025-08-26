if vim.g.ai == false then
  return {}
end

local plugins = {}

if vim.g.suggestions and vim.g.ai ~= "copilot" then
  table.insert(plugins, require("plugins.ai.neocodeium"))
end

table.insert(plugins, require("plugins.ai." .. vim.g.ai))

return plugins
