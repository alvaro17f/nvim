Pack.add({ "https://github.com/MagicDuck/grug-far.nvim" })

local grug_far = require("grug-far")

grug_far.setup({
  engine = "ripgrep",
  headerMaxWidth = 80,
  transient = true,
})

vim.keymap.set("n", "<leader>r", function()
  grug_far.open({ prefills = { paths = vim.fn.expand("%") } })
end, { desc = "Replace" })

vim.keymap.set("v", "<leader>r", function()
  grug_far.with_visual_selection({ prefills = { paths = vim.fn.expand("%") } })
end, { desc = "Replace" })
