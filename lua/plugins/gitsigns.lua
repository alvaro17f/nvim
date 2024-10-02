local icons = {
  add = { text = "+" },
  change = { text = "~" },
  delete = { text = "_" },
  topdelete = { text = "‾" },
  changedelete = { text = "~" },
}

return {
  "lewis6991/gitsigns.nvim",
  event = "BufEnter",
  keys = {
    {
      mode = "n",
      "<leader>g;",
      ":Gitsigns preview_hunk_inline<CR>",
      silent = true,
      desc = "Gitsigns preview hunk inline",
    },
    {
      mode = "n",
      "[g",
      ":Gitsigns prev_hunk<CR>",
      silent = true,
      desc = "Gitsigns previous hunk",
    },
    {
      mode = "n",
      "]g",
      ":Gitsigns next_hunk<CR>",
      silent = true,
      desc = "Gitsigns next hunk",
    },
    {
      mode = "n",
      "<leader>gb",
      ":Gitsigns blame_line<CR>",
      silent = true,
      desc = "Gitsigns blame line",
    },
  },
  opts = {
    current_line_blame = true,
    sign_priority = 0,
    signs = icons,
    signs_staged = icons,
  },
}
