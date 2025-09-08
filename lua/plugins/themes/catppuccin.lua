-- https://github.com/catppuccin/nvim#configuration
vim.pack.add({ { src = "https://github.com/catppuccin/nvim", name = "catppuccin" } }, { load = true, confirm = false })

require("catppuccin").setup({
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
  },
})

vim.cmd.colorscheme("catppuccin")
