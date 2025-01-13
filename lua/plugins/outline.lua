return {
  "hedyhli/outline.nvim",
  lazy = true,
  cmd = { "Outline", "OutlineOpen" },
  keys = {
    { "|", "<cmd>Outline<CR>", desc = "Toggle outline" },
  },
  opts = {
    outline_window = {
      auto_close = true,
    },
    symbol_folding = {
      autofold_depth = 1, -- 1 or false
      auto_unfold = {
        hovered = true,
      },
    },
  },
}
