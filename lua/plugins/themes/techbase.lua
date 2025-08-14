return {
  "mcauley-penney/techbase.nvim",
  name = "techbase",
  lazy = false,
  priority = 1000,
  opts = {
    italic_comments = true,
    transparent = true,
    hl_overrides = {},
  },
  config = function(_, opts)
    require("techbase").setup(opts)
    vim.cmd.colorscheme("techbase")
  end,
}
