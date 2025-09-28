Pack.add({ { src = "https://github.com/folke/tokyonight.nvim", name = "tokyonight" } })

local tokyonight = require("tokyonight")

tokyonight.setup({
  style = "night",

  transparent = true,
  lualine_bold = true,

  styles = {
    comments = { italic = true },
    keywords = { italic = true },
    functions = {},
    variables = {},
    sidebars = "transparent",
    floats = "transparent",
  },

  on_colors = function() end,

  on_highlights = function(hl, c)
    hl.BlinkCmpDocBorder = { fg = c.comment }
    hl.BlinkCmpMenuBorder = { fg = c.comment }
    hl.FloatBorder = { fg = c.comment }
    hl.NormalFloat = { bg = c.none }
    hl.StatusLine = { bg = c.none }
    hl.WinBar = { bg = c.none, fg = c.fg }
    hl.WinSeparator = { fg = c.comment }
  end,
})

vim.cmd.colorscheme("tokyonight")
