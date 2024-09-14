return {
  "DreamMaoMao/yazi.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "nvim-lua/plenary.nvim",
  },
  name = "yazi",
  keys = {
    { mode = 'n', '<leader>/', ':Yazi<CR>', silent = true, desc = 'Toggle Yazi' },
  }
}
