return {
  'saecki/crates.nvim',
  name = "crates",
  event = { 'BufRead Cargo.toml' },
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    require('crates').setup()
  end,
}
