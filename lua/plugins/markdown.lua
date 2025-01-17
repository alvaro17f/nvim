local filetypes = {
  "markdown",
}

if vim.g.copilot then
  table.insert(filetypes, "codecompanion")
end

return {
  "OXY2DEV/markview.nvim",
  branch = "dev",
  ft = filetypes,
  opts = {
    filetypes = filetypes,
    preview = {
      ignore_buftypes = {},
    },
  },
}
