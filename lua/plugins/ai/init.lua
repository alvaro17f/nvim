local plugins = {}

if Flags.ai_chat then
  table.insert(plugins, require("plugins.ai." .. Flags.ai_chat))
end

if Flags.ai_suggestions and Flags.ai_suggestions ~= "lsp" then
  table.insert(plugins, require("plugins.ai." .. Flags.ai_suggestions))
end

return plugins
