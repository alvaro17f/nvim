Pack.add({ "https://github.com/folke/lazydev.nvim" })

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "lua" },
  callback = function()
    local lazydev = require("lazydev")

    lazydev.setup({
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        { path = "snacks.nvim", words = { "Snacks" } },
      },
    })
  end,
})
