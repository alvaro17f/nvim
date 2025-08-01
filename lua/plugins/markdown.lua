local filetypes = {
  "markdown",
}

local plugins = {
  markview = {
    "OXY2DEV/markview.nvim",
    ft = filetypes,
    opts = {
      preview = {
        filetypes = filetypes,
        ignore_buftypes = {},
      },
    },
  },

  render_markdown = {
    "MeanderingProgrammer/render-markdown.nvim",
    event = { "BufReadPre", "BufNewFile" },
    ft = filetypes,
    opts = {
      anti_conceal = { enabled = false },
      file_types = filetypes,
    },
  },
}

return plugins.markview
