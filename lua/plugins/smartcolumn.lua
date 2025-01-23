local filetypes = {
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

if vim.g.copilot then
  table.insert(filetypes, "codecompanion")
end

return {
  "m4xshen/smartcolumn.nvim",
  opts = {
    colorcolumn = "80",
    disabled_filetypes = filetypes,
    custom_colorcolumn = {},
    scope = "file",
  },
}
