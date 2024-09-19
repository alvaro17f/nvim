return {
  "lewis6991/gitsigns.nvim",
  event = "BufEnter",
  keys = {
    {
      mode = "n",
      "g;",
      ":Gitsigns preview_hunk_inline<CR>",
      silent = true,
      desc = "Gitsigns preview hunk inline",
    },
    {
      mode = "n",
      "g[",
      ":Gitsigns prev_hunk<CR>",
      silent = true,
      desc = "Gitsigns previous hunk",
    },
    {
      mode = "n",
      "g]",
      ":Gitsigns next_hunk<CR>",
      silent = true,
      desc = "Gitsigns next hunk",
    },
  },
  opts = {
    current_line_blame = true,
    sign_priority = 0,
    signs = {
      add = { text = "+" },
      change = { text = "~" },
      delete = { text = "_" },
      topdelete = { text = "‾" },
      changedelete = { text = "~" },
    },
  },
}
