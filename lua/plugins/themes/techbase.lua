vim.pack.add(
  { { src = "https://github.com/mcauley-penney/techbase.nvim", name = "techbase" } },
  { load = true, confirm = false }
)

require("techbase").setup({
  italic_comments = true,
  transparent = true,
  hl_overrides = {},
})

vim.cmd.colorscheme("techbase")
