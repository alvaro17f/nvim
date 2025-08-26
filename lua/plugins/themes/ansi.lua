vim.pack.add({ { "https://github.com/stevedylandev/ansi-nvim", name = "ansi" } }, { load = true, confirm = false })

vim.cmd.colorscheme("ansi")
vim.opt.termguicolors = false
