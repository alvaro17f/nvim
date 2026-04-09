local plugins = {}

if Flags.agent then
  table.insert(plugins, require("plugins.ai." .. Flags.agent))
end

if Flags.suggestions and Flags.suggestions ~= "lsp" then
  table.insert(plugins, require("plugins.ai." .. Flags.suggestions))
end

return plugins
