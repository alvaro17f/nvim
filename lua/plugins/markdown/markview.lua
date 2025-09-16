Pack.add({
  "https://github.com/OXY2DEV/markview.nvim",
  "https://github.com/OXY2DEV/helpview.nvim",
})

local helpview = require("helpview")
local markview = require("markview")

markview.setup({
  preview = {
    filetypes = vim.g.markdown_filetypes,
    ignore_buftypes = {},
  },
})

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "help",
  callback = function()
    helpview.setup()
  end,
})
