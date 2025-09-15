if Flags.ai == false then
  return {}
end

local plugins = {}

if Flags.suggestions and Flags.ai ~= "copilot" then
  table.insert(plugins, require("plugins.ai.neocodeium"))
end

table.insert(plugins, require("plugins.ai." .. Flags.ai))

return plugins
