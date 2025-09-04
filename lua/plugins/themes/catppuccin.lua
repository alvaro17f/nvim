-- https://github.com/catppuccin/nvim#configuration
vim.pack.add({ { src = "https://github.com/catppuccin/nvim", name = "catppuccin" } }, { load = true, confirm = false })

require("catppuccin").setup({
  flavour = "mocha",
  transparent_background = true,
  float = {
    transparent = true,
    solid = true,
  },
  custom_highlights = function(colors)
    return {
      BlinkCmpMenuBorder = { fg = colors.blue },
      BlinkCmpDocBorder = { fg = colors.sapphire },
      BlinkCmpSignatureHelpBorder = { fg = colors.blue },
    }
  end,
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
