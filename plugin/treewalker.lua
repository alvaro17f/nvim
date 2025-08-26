vim.pack.add({ "https://github.com/aaronik/treewalker.nvim" }, { load = true, confirm = false })

require("treewalker").setup({
  highlight = true,
})

vim.keymap.set("n", "<a-s-j>", "<CMD>Treewalker Down<CR>", { desc = "Treewalker Down" })
vim.keymap.set("n", "<a-s-k>", "<CMD>Treewalker Up<CR>", { desc = "Treewalker Up" })
vim.keymap.set("n", "<a-s-h>", "<CMD>Treewalker Left<CR>", { desc = "Treewalker Left" })
vim.keymap.set("n", "<a-s-l>", "<CMD>Treewalker Right<CR>", { desc = "Treewalker Right" })
