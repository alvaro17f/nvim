if vim.g.explorer == false then
  return {}
end

return { require("plugins.explorer." .. vim.g.explorer) }
