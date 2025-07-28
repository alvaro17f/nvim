if not vim.g.theme then
  return {}
end

return { require("plugins.themes." .. vim.g.theme) }
