Pack.add({ "https://github.com/RRethy/base16-nvim" })

--------------------------
local theme = "taro"
--------------------------

vim.g.lualine = "base16"
vim.o.winborder = "none"

local base16 = require("base16-colorscheme")

local opts = require("plugins.themes.base16." .. theme)

base16.setup(opts)
