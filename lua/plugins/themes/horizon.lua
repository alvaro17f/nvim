Pack.add({ "https://github.com/akinsho/horizon.nvim" })

local horizon = require("horizon")

horizon.setup()

vim.api.nvim_set_hl(0, "BlinkCmpDocBorder", { fg = Utils.color("Comment") })
vim.api.nvim_set_hl(0, "BlinkCmpMenuBorder", { fg = Utils.color("Comment") })
vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none", fg = Utils.color("Comment") })
vim.api.nvim_set_hl(0, "Normal", { bg = Utils.color("Normal", "bg") })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none", fg = Utils.color("Text") })
vim.api.nvim_set_hl(0, "SnacksDashboardHeader", { fg = Utils.color("WarningMsg") })
vim.api.nvim_set_hl(0, "SnacksIndentScope", { fg = Utils.color("ErrorMsg") })
vim.api.nvim_set_hl(0, "SnacksPickerBorder", { fg = Utils.color("Normal", "bg") })
vim.api.nvim_set_hl(0, "SnacksPickerDir", { fg = Utils.color("Keyword") })
vim.api.nvim_set_hl(0, "WinSeparator", { fg = Utils.color("Comment") })
