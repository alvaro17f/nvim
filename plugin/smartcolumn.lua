vim.pack.add({ "https://github.com/m4xshen/smartcolumn.nvim" }, { load = true, confirm = false })

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

require("smartcolumn").setup({
  colorcolumn = "80",
  disabled_filetypes = filetypes,
  custom_colorcolumn = {},
  scope = "file",
})
