local filetypes = {
  "markdown",
}

if vim.g.copilot then
  table.insert(filetypes, "codecompanion")
end

return {
  "OXY2DEV/markview.nvim",
  ft = filetypes,
  opts = {
    preview = {
      filetypes = filetypes,
      ignore_buftypes = {},
    },
  },
}
