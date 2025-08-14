return {
  "stevedylandev/ansi-nvim",
  name = "ansi",
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd.colorscheme("ansi")
    vim.opt.termguicolors = false
  end,
}
