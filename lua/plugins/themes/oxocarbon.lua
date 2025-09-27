Pack.add({ { src = "https://github.com/nyoom-engineering/oxocarbon.nvim", name = "oxocarbon" } })

---@param opts { transparent?: boolean, lualine?: string }
local setup = function(opts)
  vim.g.lualine = opts.lualine or "auto"

  vim.o.background = "dark"
  vim.o.winborder = "none"

  vim.cmd.colorscheme("oxocarbon")

  if opts.transparent then
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
  end

  vim.api.nvim_set_hl(0, "SnacksDashboardHeader", { fg = Utils.color("ErrorMsg") })
  vim.api.nvim_set_hl(0, "SnacksIndentScope", { fg = Utils.color("ErrorMsg") })
  vim.api.nvim_set_hl(0, "WinBar", { bg = "none" })
end

setup({
  lualine = "horizon",
})
