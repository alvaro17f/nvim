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
      function()
        require("gitsigns").preview_hunk_inline()
      end,
      silent = true,
      desc = "Gitsigns preview hunk inline",
    },
    {
      mode = "n",
      "[g",
      function()
        require("gitsigns").nav_hunk("prev", { target = "all" })
      end,
      silent = true,
      desc = "Gitsigns previous hunk",
    },
    {
      mode = "n",
      "]g",
      function()
        require("gitsigns").nav_hunk("next", { target = "all" })
      end,
      silent = true,
      desc = "Gitsigns next hunk",
    },
    {
      mode = "n",
      "<leader>gb",
      function()
        require("gitsigns").blame_line()
      end,
      silent = true,
      desc = "Gitsigns blame line",
    },
  },
  opts = {
    preview_config = { border = "rounded" },
    current_line_blame = true,
    sign_priority = 0,
    signs = icons,
    signs_staged = icons,
  },
}
