------------------------------------
--OPTIONS
------------------------------------
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = false

vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)
vim.opt.autochdir = true
vim.opt.backup = false
vim.opt.breakindent = true
vim.opt.cmdheight = 1
vim.opt.colorcolumn = "80"
vim.opt.completeopt = "menuone,noselect"
vim.opt.cursorline = true
vim.opt.expandtab = true
vim.opt.hidden = true
vim.opt.hlsearch = false
vim.opt.ignorecase = true
vim.opt.inccommand = "split"
vim.opt.incsearch = true
vim.opt.laststatus = 3
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.mouse = "a"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 999
vim.opt.shiftwidth = 2
vim.opt.shortmess:append({ c = true })
vim.opt.showmode = false
vim.opt.showtabline = 0
vim.opt.sidescrolloff = 999
vim.opt.signcolumn = "yes"
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.softtabstop = 2
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.swapfile = false
vim.opt.tabstop = 2
vim.opt.termguicolors = true
vim.opt.timeoutlen = 300
vim.opt.undofile = true
vim.opt.updatetime = 250
vim.opt.wrap = false
