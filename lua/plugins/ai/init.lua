local plugins = {}

if Flags.copilot then
  table.insert(plugins, require("plugins.ai." .. Flags.copilot))
end

if Flags.suggestions and Flags.suggestions ~= "lsp" then
  table.insert(plugins, require("plugins.ai." .. Flags.suggestions))
end

return plugins
