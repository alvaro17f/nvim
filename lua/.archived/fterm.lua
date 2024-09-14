return {
  'numToStr/FTerm.nvim',
  name = "fterm",
  keys = {
    { mode = 'n', '<C-\\>', '<CMD>lua require("FTerm").toggle()<CR>', silent = true, desc = 'Toggle terminal' },
    { mode = 't', '<C-\\>', '<CMD>lua require("FTerm").toggle()<CR>', silent = true, desc = 'Toggle terminal' },
  },
  config = function()
    local fterm = require("FTerm")
    ------------------------
    -- TERMINAL
    ------------------------
    fterm.setup({
      border     = 'double',
      auto_close = true,
      blend      = 9,
      dimensions = {
        height = 0.9,
        width = 0.9,
      },
    })
  end
}
