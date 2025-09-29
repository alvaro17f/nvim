Pack.add({ { src = "https://github.com/embark-theme/vim", name = "embark" } })

vim.cmd.colorscheme("embark")

vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none", fg = Utils.color("Comment") })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none", fg = Utils.color("Text") })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
vim.api.nvim_set_hl(0, "SnacksPickerBorder", { fg = Utils.color("Normal", "bg") })
vim.api.nvim_set_hl(0, "SnacksPickerDir", { fg = Utils.color("Keyword") })
