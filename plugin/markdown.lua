vim.g.markdown_plugin = "markview"
vim.g.markdown_filetypes = {
  "markdown",
}

return { require("plugins.markdown." .. vim.g.markdown_plugin) }
