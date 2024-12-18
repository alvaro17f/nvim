return {
  "folke/todo-comments.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    { mode = "n", "<leader>ft", ":TodoFzfLua<CR>", silent = true, desc = "show TODO" },
  },
  config = function()
    local todo_comments = require("todo-comments")
    todo_comments.setup()
  end,
}
