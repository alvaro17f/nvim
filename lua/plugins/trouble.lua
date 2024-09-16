return {
  "folke/trouble.nvim",
  opts = {},
  cmd = "Trouble",
  keys = {
    {
      mode = "n",
      "<leader>x",
      "<cmd>Trouble diagnostics toggle focus=true<cr>",
      silent = true,
      desc = "Trouble diagnostics",
    },
  },
}
