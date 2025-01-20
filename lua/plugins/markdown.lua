local filetypes = {
  "markdown",
}

if vim.g.copilot then
  table.insert(filetypes, "codecompanion")
end

return {
  "MeanderingProgrammer/render-markdown.nvim",
  event = { "BufReadPre", "BufNewFile" },
  ft = filetypes,
  opts = {
    file_types = filetypes,
  },
}
