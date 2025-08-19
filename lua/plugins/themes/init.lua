if vim.g.theme == false then
  return {}
end

return { require("plugins.themes." .. vim.g.theme) }
