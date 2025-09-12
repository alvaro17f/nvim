Pack.add({ "https://github.com/MeanderingProgrammer/render-markdown.nvim" })

vim.g.markdown_filetypes = {
  "markdown",
}

local icons = require("utils.icons").core.heading

require("render-markdown").setup({
  anti_conceal = { enabled = false },
  file_types = vim.g.markdown_filetypes,
  heading = {
    icons = icons,
  },
  restart_highlighter = true,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown" },
  desc = "Fix render-markdown highlighting checkhealth",
  callback = function(args)
    vim.treesitter.start(args.buf, "markdown")
  end,
})
