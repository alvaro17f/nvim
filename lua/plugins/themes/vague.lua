Pack.add({ { src = "https://github.com/vague2k/vague.nvim", name = "vague" } })

local vague = require("vague")

vague.setup({ transparent = true })

vim.cmd.colorscheme("vague")
