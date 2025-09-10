------------------------------------
-- OPTIONS
------------------------------------
vim.g.mapleader = " "
vim.g.maplocalleader = vim.g.mapleader
------------------------------------
vim.g.autocomplete = false
vim.g.autosave = true
vim.g.inlayhints = false
------------------------------------
vim.cmd.filetype("plugin indent on")
if vim.fn.exists("syntax_on") ~= 1 then
  vim.cmd("syntax enable")
end
------------------------------------
vim.o.autochdir = true
vim.o.autocomplete = false
vim.o.autoread = true
vim.o.autowrite = vim.g.autosave
vim.o.autowriteall = vim.g.autosave
vim.o.backup = false
vim.o.breakindent = true
vim.o.cmdheight = 0
vim.o.colorcolumn = "80"
vim.o.complete = ".,b,o,u,w"
vim.o.completefuzzycollect = "keyword,files,whole_line"
vim.o.completeopt = "fuzzy,menuone,noselect,popup"
vim.o.cursorline = true
vim.o.expandtab = true
vim.o.hidden = true
vim.o.hlsearch = false
vim.o.ignorecase = true
vim.o.inccommand = "split"
vim.o.incsearch = true
vim.o.laststatus = 3
vim.o.list = true
vim.o.mouse = "a"
vim.o.number = true
vim.o.pummaxwidth = 100
vim.o.relativenumber = true
vim.o.scrolloff = 999
vim.o.shiftround = true
vim.o.shiftwidth = 2
vim.o.showmode = true
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
vim.o.undofile = true
vim.o.updatetime = 250
vim.o.wildmode = "noselect:lastused"
vim.o.wildoptions = "pum,fuzzy"
vim.o.winborder = "rounded"
vim.o.wrap = false
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.shortmess:append({ c = true })
------------------------------------
vim.schedule(function()
  vim.o.clipboard = vim.env.SSH_TTY and "" or "unnamedplus"
end)
------------------------------------
-- DISABLED PLUGINS
------------------------------------
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrwSettings = 1
vim.g.loaded_netrwFileHandlers = 1
vim.g.loaded_gzip = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_getscript = 1
vim.g.loaded_getscriptPlugin = 1
vim.g.loaded_vimball = 1
vim.g.loaded_vimballPlugin = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_logipat = 1
vim.g.loaded_rrhelper = 1
vim.g.loaded_spellfile_plugin = 1
vim.g.loaded_matchit = 1
