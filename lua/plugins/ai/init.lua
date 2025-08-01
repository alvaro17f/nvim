if not vim.g.ai then
  return {}
end

local plugins = {}

if vim.g.suggestions then
  table.insert(plugins, require("plugins.ai.neocodeium"))
end

table.insert(plugins, require("plugins.ai." .. vim.g.ai))

return plugins
