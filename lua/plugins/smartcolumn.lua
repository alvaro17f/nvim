local disabled_filetypes = {
  "checkhealth",
  "grug-far",
  "help",
  "lazy",
  "lazydo",
  "lazygit",
  "markdown",
  "mason",
  "minifiles",
  "noice",
  "snacks_dashboard",
  "snacks_terminal",
  "snacks_picker_input",
  "text",
  "trouble",
  "yazi",
}

return {
  "m4xshen/smartcolumn.nvim",
  opts = {
    colorcolumn = "80",
    disabled_filetypes = disabled_filetypes,
    custom_colorcolumn = {},
    scope = "file",
  },
}
