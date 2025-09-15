Pack.add({ "https://github.com/Bekaboo/deadcolumn.nvim" })

require("deadcolumn").setup({
  blending = {
    hlgroup = { "Whitespace", "fg" }, --:help highlight-gruoups
    threshold = 0.75,
  },
  warning = {
    alpha = 0.9,
    colorcode = Utils.color("Error"),
  },
})
