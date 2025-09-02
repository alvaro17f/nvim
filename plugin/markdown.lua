vim.pack.add({ "https://github.com/MeanderingProgrammer/render-markdown.nvim" }, { load = true, confirm = false })

vim.g.markdown_filetypes = {
  "markdown",
}

require("render-markdown").setup({
  anti_conceal = { enabled = false },
  file_types = vim.g.markdown_filetypes,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown" },
  desc = "Fix render-markdown highlighting",
  callback = function(args)
    vim.treesitter.start(args.buf, "markdown")
  end,
})
