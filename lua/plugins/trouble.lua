return {
  "folke/trouble.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "folke/todo-comments.nvim",
  },
  opts = {
    auto_close = true,
    focus = true,
  },
  cmd = "Trouble",
  keys = {
    {
      mode = "n",
      "<leader>xw",
      ":Trouble diagnostics toggle<CR>",
      silent = true,
      desc = "Trouble: workspace diagnostics",
    },
    {
      mode = "n",
      "<leader>xd",
      ":Trouble diagnostics toggle filter.buf=0<CR>",
      silent = true,
      desc = "Trouble: document diagnostics",
    },
    {
      mode = "n",
      "<leader>xq",
      ":Trouble quickfix toggle<CR>",
      silent = true,
      desc = "Trouble: quickfix list",
    },
    {
      mode = "n",
      "<leader>xl",
      ":Trouble loclist toggle<CR>",
      silent = true,
      desc = "Trouble: location list",
    },
    {
      mode = "n",
      "<leader>xt",
      ":Trouble todo toggle<CR>",
      silent = true,
      desc = "Trouble: TODO",
    },
  },
}
