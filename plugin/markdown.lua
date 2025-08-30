vim.pack.add({ "https://github.com/MeanderingProgrammer/render-markdown.nvim" }, { load = true, confirm = false })

vim.g.markdown_filetypes = {
  "markdown",
}

require("render-markdown").setup({
  anti_conceal = { enabled = false },
  file_types = vim.g.markdown_filetypes,
})
