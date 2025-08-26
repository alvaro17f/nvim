vim.pack.add({ "https://github.com/folke/which-key.nvim" }, { load = true, confirm = false })

require("which-key").setup({
  preset = "helix",
})
