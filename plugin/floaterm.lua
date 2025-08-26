vim.pack.add({
  { src = "https://github.com/nvzone/floaterm" },
  { src = "https://github.com/nvzone/volt" },
}, { load = true, confirm = false })

require("floaterm").setup()

vim.keymap.set({ "n", "t" }, "<C-\\>", "<CMD>FloatermToggle<CR>", { desc = "Toggle floaterm" })
