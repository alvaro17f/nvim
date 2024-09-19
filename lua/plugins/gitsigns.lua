return {
  "lewis6991/gitsigns.nvim",
  event = "BufEnter",
  keys = {
    {
      mode = "n",
      "<leader>gp",
      ":Gitsigns preview_hunk_inline<CR>",
      silent = true,
      desc = "Gitsigns Preview Hunk",
    },
  },
  opts = {
    current_line_blame = true,
  },
}
