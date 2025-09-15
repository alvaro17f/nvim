local plugins = {}

if Flags.ai_chat then
  table.insert(plugins, require("plugins.ai." .. Flags.ai_chat))
end

if Flags.ai_suggestions == "neocodeium" then
  table.insert(plugins, require("plugins.ai.neocodeium"))
end

return plugins
