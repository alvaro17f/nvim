return {
  "aaronik/treewalker.nvim",
  keys = {
    { mode = "n", "<a-s-j>", "<CMD>Treewalker Down<CR>", silent = true, desc = "Treewalker Down" },
    { mode = "n", "<a-s-k>", "<CMD>Treewalker Up<CR>", silent = true, desc = "Treewalker Up" },
    { mode = "n", "<a-s-h>", "<CMD>Treewalker Left<CR>", silent = true, desc = "Treewalker Left" },
    { mode = "n", "<a-s-l>", "<CMD>Treewalker Right<CR>", silent = true, desc = "Treewalker Right" },
  },
  opts = {
    highlight = true,
  },
}
