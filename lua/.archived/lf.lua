return {
  "lmburns/lf.nvim",
  name = "lf",
  cmd = "Lf",
  dependencies = { "nvim-lua/plenary.nvim", "akinsho/toggleterm.nvim" },
  opts = {
    winblend = 0,
    --height = 50,
    --width = 150,
    highlights = { NormalFloat = { guibg = "" } },
    border = "rounded",
    escape_quit = true,
  },
  keys = {
    { mode = 'n', '<leader>/', ':Lf<CR>', silent = true, desc = 'Toggle Lf' },
  }
}
