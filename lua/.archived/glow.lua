return {
  "ellisonleao/glow.nvim",
  name = "glow",
  keys = {
    { mode = 'n', '<C-m>', ':Glow!<CR>', silent = true, desc = 'toggle markdown preview' },
  },
  config = function()
    require('glow').setup()
  end,
}
