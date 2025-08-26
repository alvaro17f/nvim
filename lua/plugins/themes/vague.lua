vim.pack.add({ { src = "https://github.com/vague2k/vague.nvim", name = "vague" } }, { load = true, confirm = false })

require("vague").setup({ transparent = true })
vim.cmd("colorscheme vague")
vim.cmd(":hi statusline guibg=NONE")
