------------------------------------
-- OPTIONS
------------------------------------
vim.g.mapleader = " "
vim.g.maplocalleader = " "
------------------------------------
vim.g.ai = require("utils.flags").get_flags("ai") or false
vim.g.debugger = require("utils.flags").get_flags("debugger") or false
vim.g.logo = require("utils.flags").get_flags("logo") or "neovim"
vim.g.suggestions = require("utils.flags").get_flags("suggestions") or false
vim.g.tests = require("utils.flags").get_flags("tests") or false
vim.g.theme = require("utils.flags").get_flags("theme") or false
------------------------------------
vim.o.autochdir = true
vim.o.backup = false
vim.o.breakindent = true
vim.o.cmdheight = 1
vim.o.colorcolumn = "80"
vim.o.completeopt = "menu,menuone,noselect"
vim.o.cursorline = true
vim.o.expandtab = true
vim.o.hidden = true
vim.o.hlsearch = false
vim.o.ignorecase = true
vim.o.inccommand = "split"
vim.o.incsearch = true
vim.o.laststatus = 3
vim.o.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.o.mouse = "a"
vim.o.number = true
vim.o.relativenumber = true
vim.o.scrolloff = 999
vim.o.shiftround = true
vim.o.shiftwidth = 2
vim.opt.shortmess:append({ c = true })
vim.o.showmode = false
vim.o.showtabline = 0
vim.o.sidescrolloff = 999
vim.o.smartcase = true
vim.o.smartindent = true
vim.o.softtabstop = 2
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.swapfile = false
vim.o.tabstop = 2
vim.o.termguicolors = true
vim.o.timeoutlen = 300
vim.o.updatetime = 250
vim.o.winborder = "rounded"
vim.o.wrap = false
------------------------------------
vim.schedule(function()
  vim.o.clipboard = vim.env.SSH_TTY and "" or "unnamedplus"
end)
------------------------------------
