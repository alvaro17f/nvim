Pack.add({ { src = "https://github.com/nyoom-engineering/oxocarbon.nvim", name = "oxocarbon" } })

vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })

vim.opt.background = "dark"
vim.cmd.colorscheme("oxocarbon")
