return {
  'uga-rosa/ccc.nvim',
  name = "ccc",
  lazy = false,
  config = function()
    local ccc = require("ccc")
    --local mapping = ccc.mapping
    ccc.setup({
      highlighter = {
        auto_enable = true
      },
      --mappings = {
      --}
    })
  end,
}
