Pack.add({ { src = "https://github.com/vague2k/vague.nvim", name = "vague" } })

local vague = require("vague")

vague.setup({
  transparent = false,

  on_highlights = function(hl, c)
    hl.FloatBorder = { bg = c.bg, fg = c.comment }
    hl.SnacksDashboardHeader = { fg = c.type }
    hl.SnacksIndentScope = { fg = c.string }
    hl.WinBar = { bg = c.bg, fg = c.fg }
    hl.WinSeparator = { fg = c.comment }
  end,
})

vim.cmd.colorscheme("vague")
