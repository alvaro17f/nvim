if vim.g.explorer == false then
  return {}
end

return { require("plugins.explorers." .. vim.g.explorer) }
