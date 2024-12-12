return {
  "aaronik/treewalker.nvim",
  keys = {
    { mode = "n", "<a-s-j>", ":Treewalker Down<CR>", silent = true, desc = "Treewalker Down" },
    { mode = "n", "<a-s-k>", ":Treewalker Up<CR>", silent = true, desc = "Treewalker Up" },
    { mode = "n", "<a-s-h>", ":Treewalker Left<CR>", silent = true, desc = "Treewalker Left" },
    { mode = "n", "<a-s-l>", ":Treewalker Right<CR>", silent = true, desc = "Treewalker Right" },
  },
  opts = {
    highlight = true,
  },
}
