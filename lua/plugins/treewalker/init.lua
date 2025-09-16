Pack.add({ "https://github.com/aaronik/treewalker.nvim" })

local treewalker = require("treewalker")

treewalker.setup({
  highlight = true,
})

vim.keymap.set("n", "<a-s-j>", treewalker.move_down, { desc = "Treewalker Down" })
vim.keymap.set("n", "<a-s-k>", treewalker.move_up, { desc = "Treewalker Up" })
vim.keymap.set("n", "<a-s-h>", treewalker.move_out, { desc = "Treewalker Left" })
vim.keymap.set("n", "<a-s-l>", treewalker.move_in, { desc = "Treewalker Right" })
