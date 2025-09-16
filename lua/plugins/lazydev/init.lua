Pack.add({ "https://github.com/folke/lazydev.nvim" })

local lazydev = require("lazydev")

lazydev.setup({
  library = {
    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
    { path = "snacks.nvim", words = { "Snacks" } },
  },
})
