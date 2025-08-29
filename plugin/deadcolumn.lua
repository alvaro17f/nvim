vim.pack.add({ "https://github.com/Bekaboo/deadcolumn.nvim" }, { load = true, confirm = false })

require("deadcolumn").setup({
  blending = {
    hlgroup = { "DiffText", "bg" }, --:help highlight-gruoups
    threshold = 0.75,
  },
  warning = {
    alpha = 0.9,
    colorcode = "#b3003f",
  },
})
