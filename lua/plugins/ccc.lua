return {
  "uga-rosa/ccc.nvim",
  name = "ccc",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    highlighter = {
      auto_enable = true,
      lsp = true,
    },
  },
}
