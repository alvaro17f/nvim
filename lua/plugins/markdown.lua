local filetypes = {
  "markdown",
}

if vim.g.ai then
  local ai_filetypes = {
    codecompanion = "codecompanion",
    opencode = "opencode_output",
  }

  table.insert(filetypes, ai_filetypes[vim.g.copilot])
end

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

return plugins.render_markdown
