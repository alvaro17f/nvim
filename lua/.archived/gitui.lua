return {
  'aspeddro/gitui.nvim',
  name = "gitui",
  keys = {
    { mode = 'n', '<leader>g', '<CMD>lua require("gitui").open()<CR>', silent = true, desc = 'Gitui' },
  },
  config = function()
    require("gitui").setup()
  end,
}
