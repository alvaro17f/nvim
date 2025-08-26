vim.pack.add(
  { { src = "https://github.com/neanias/everforest-nvim", name = "everforest" } },
  { load = true, confirm = false }
)

require("everforest").setup({
  background = "hard", -- "soft", "medium" or "hard"
  transparent_background_level = 2, -- 0 to 2
  italics = true,
  disable_italic_comments = false,
  sign_column_background = "none", -- "none" or "grey"
  ui_contrast = "low", -- "low" or "high"
  dim_inactive_windows = false,
  diagnostic_text_highlight = false,
  diagnostic_virtual_text = "coloured", -- "coloured" or "grey"
  diagnostic_line_highlight = false,
  spell_foreground = false,
  show_eob = false,
  float_style = "bright", -- "bright" or "dim"
  inlay_hints_background = "none", -- "none" or "dimmed"

  ---@param hl Highlights
  ---@param palette Palette
  on_highlights = function(hl, palette)
    hl.NormalFloat = { fg = palette.fg, bg = palette.none }
    hl.FloatBorder = { fg = palette.fg, bg = palette.none }
    hl.CursorLineNr = { fg = palette.yellow }
  end,

  ---@param palette Palette
  colours_override = function(palette) end,
})

vim.cmd.colorscheme("everforest")
