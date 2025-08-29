vim.pack.add({ "https://github.com/Bekaboo/deadcolumn.nvim" }, { load = true, confirm = false })

require("deadcolumn").setup({
  blending = {
    colorcode = "#1e1e2e",
    hlgroup = { "NonText", "bg" },
    threshold = 0.75,
  },
  warning = {
    alpha = 0.9,
    colorcode = "#b3003f",
  },
})
