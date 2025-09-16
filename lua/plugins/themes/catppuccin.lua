-- https://github.com/catppuccin/nvim#configuration
Pack.add({ { src = "https://github.com/catppuccin/nvim", name = "catppuccin" } })

local catppuccin = require("catppuccin")

catppuccin.setup({
  flavour = "mocha",
  transparent_background = true,
  float = {
    transparent = true,
    solid = true,
  },
  auto_integrations = true,
  integrations = {
    native_lsp = {
      enabled = true,
      underlines = {
        errors = { "undercurl" },
        hints = { "undercurl" },
        warnings = { "undercurl" },
        information = { "undercurl" },
      },
    },
    snacks = {
      enabled = true,
      indent_scope_color = "teal",
    },
  },
})

vim.cmd.colorscheme("catppuccin")
