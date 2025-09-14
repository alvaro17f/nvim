Pack.add({ { src = "https://github.com/mcauley-penney/techbase.nvim", name = "techbase" } })

require("techbase").setup({
  italic_comments = true,
  transparent = true,
  hl_overrides = {},
})

vim.cmd.colorscheme("techbase")
