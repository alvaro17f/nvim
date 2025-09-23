Pack.add({ { src = "https://github.com/nyoom-engineering/oxocarbon.nvim", name = "oxocarbon" } })

vim.g.lualine = "horizon"

vim.o.background = "dark"
vim.o.winborder = "none"

local transparent = true

if transparent then
  vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
  vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
  vim.api.nvim_set_hl(0, "WinBar", { bg = "none" })
end

vim.cmd.colorscheme("oxocarbon")
