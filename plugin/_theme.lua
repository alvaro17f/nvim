if Flags.theme == false then
  return {}
end

return { require("plugins.themes." .. Flags.theme) }
