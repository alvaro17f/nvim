-- https://github.com/catppuccin/nvim#configuration
return {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false,
  priority = 1000,
  opts = {
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
        underlines = {
          errors = { "undercurl" },
          hints = { "undercurl" },
          warnings = { "undercurl" },
          information = { "undercurl" },
        },
      },
    },
  },
  config = function(_, opts)
    require("catppuccin").setup(opts)
    vim.cmd.colorscheme("catppuccin")
  end,
}
