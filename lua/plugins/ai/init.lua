if not vim.g.ai then
  return {}
end

local plugins = {}

if vim.g.ai == "copilot" then
  table.insert(plugins, require("plugins.ai.copilot"))
elseif vim.g.suggestions then
  table.insert(plugins, require("plugins.ai.neocodeium"))
end

if vim.g.copilot == "opencode" then
  table.insert(plugins, require("plugins.ai.opencode"))
elseif vim.g.copilot == "codecompanion" then
  table.insert(plugins, require("plugins.ai.codecompanion"))
end

return plugins
