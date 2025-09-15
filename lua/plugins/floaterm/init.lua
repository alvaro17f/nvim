Pack.add({
  { src = "https://github.com/nvzone/floaterm" },
  { src = "https://github.com/nvzone/volt" },
})

require("floaterm").setup()

vim.keymap.set({ "n", "t" }, "<C-S-\\>", "<CMD>FloatermToggle<CR>", { desc = "Toggle floaterm" })
