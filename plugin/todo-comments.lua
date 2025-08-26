vim.pack.add({
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/folke/todo-comments.nvim",
}, { load = true, confirm = false })

require("todo-comments").setup()

vim.keymap.set("n", "<leader>ft", function()
  Snacks.picker.todo_comments()
end, { desc = "show TODO" })
