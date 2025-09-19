Pack.add({ { src = "https://github.com/mcauley-penney/techbase.nvim", name = "techbase" } })

local techbase = require("techbase")

techbase.setup({
  italic_comments = true,
  transparent = false,
  hl_overrides = {},
})

vim.cmd.colorscheme("techbase")
