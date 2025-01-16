return {
  "folke/todo-comments.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    {
      mode = "n",
      "<leader>ft",
      function()
        Snacks.picker.todo_comments()
      end,
      silent = true,
      desc = "show TODO",
    },
  },
  opts = {},
}
