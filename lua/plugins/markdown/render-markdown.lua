Pack.add({ "https://github.com/MeanderingProgrammer/render-markdown.nvim" })

local render_markdown = require("render-markdown")

render_markdown.setup({
  anti_conceal = { enabled = false },
  file_types = vim.g.markdown_filetypes,
  heading = {
    icons = Utils.icons.core.heading,
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
