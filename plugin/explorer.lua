if Flags.explorer == false then
  return {}
end

return { require("plugins.explorers." .. Flags.explorer) }
