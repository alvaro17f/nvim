vim.pack.add(
  { { src = "https://github.com/olimorris/onedarkpro.nvim", name = "onedarkpro" } },
  { load = true, confirm = false }
)

require("onedarkpro").setup({
  options = {
    cursorline = true, -- Use cursorline highlighting?
    transparency = true, -- Use a transparent background?
    terminal_colors = true, -- Use the theme's colors for Neovim's :terminal?
    lualine_transparency = true, -- Center bar transparency?
    highlight_inactive_windows = false, -- When the window is out of focus, change the normal background?
  },
  filetypes = {
    all = true,
  },
  plugins = {
    all = true,
  },
  colors = {}, -- Override default colors or create your own
  highlights = {
    Comment = { italic = true },
    Directory = { bold = true },
    ErrorMsg = { italic = true, bold = true },
  },
  styles = { -- For example, to apply bold and italic, use "bold,italic"
    types = "NONE", -- Style that is applied to types
    methods = "NONE", -- Style that is applied to methods
    numbers = "NONE", -- Style that is applied to numbers
    strings = "NONE", -- Style that is applied to strings
    comments = "NONE", -- Style that is applied to comments
    keywords = "NONE", -- Style that is applied to keywords
    constants = "NONE", -- Style that is applied to constants
    functions = "NONE", -- Style that is applied to functions
    operators = "NONE", -- Style that is applied to operators
    variables = "NONE", -- Style that is applied to variables
    parameters = "NONE", -- Style that is applied to parameters
    conditionals = "NONE", -- Style that is applied to conditionals
    virtual_text = "NONE", -- Style that is applied to virtual text
  },
})

vim.cmd.colorscheme("onedark_vivid") -- "onedark" "onelight" "onedark_vivid" "onedark_dark" "vaporwave"
