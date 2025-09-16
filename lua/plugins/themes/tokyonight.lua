Pack.add({ { src = "https://github.com/folke/tokyonight.nvim", name = "tokyonight" } })

vim.o.winborder = ""

local tokyonight = require("tokyonight")

tokyonight.setup({
  style = "moon",
  light_style = "day",
  transparent = false,
  terminal_colors = true,
  styles = {
    comments = { italic = true },
    keywords = { italic = true },
    functions = {},
    variables = {},
    sidebars = "transparent",
    floats = "transparent",
  },
  day_brightness = 0.3,
  dim_inactive = false,
  lualine_bold = true,

  on_colors = function() end,

  on_highlights = function(hl, c)
    hl.WinBar = {
      bg = c.bg,
      fg = c.fg,
    }
  end,

  cache = true,

  plugins = {
    all = package.loaded.lazy == nil,
    auto = true,
  },
})

vim.cmd.colorscheme("tokyonight")
