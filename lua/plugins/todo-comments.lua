return {
  "folke/todo-comments.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    { mode = "n", "<leader>ft", ":TodoFzfLua<CR>", silent = true, desc = "show TODO" },
  },
  opts = {},
}
