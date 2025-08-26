vim.pack.add(
  { { src = "https://github.com/folke/tokyonight.nvim", name = "tokyonight" } },
  { load = true, confirm = false }
)

require("tokyonight").setup({
  style = "moon",
  light_style = "day",
  transparent = true,
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

  ---@param colors ColorScheme
  on_colors = function(colors) end,

  ---@param highlights tokyonight.Highlights
  ---@param colors ColorScheme
  on_highlights = function(highlights, colors)
    highlights.WinBar = { bg = colors.none }
    highlights.WinBarNC = { bg = colors.none }
  end,

  cache = true,

  ---@type table<string, boolean|{enabled:boolean}>
  plugins = {
    all = package.loaded.lazy == nil,
    auto = true,
  },
})

vim.cmd.colorscheme("tokyonight")
