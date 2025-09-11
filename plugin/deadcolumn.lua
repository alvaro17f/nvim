vim.pack.add({ "https://github.com/Bekaboo/deadcolumn.nvim" }, { load = true, confirm = false })

local color = require("utils").color

require("deadcolumn").setup({
  blending = {
    hlgroup = { "Whitespace", "fg" }, --:help highlight-gruoups
    threshold = 0.75,
  },
  warning = {
    alpha = 0.9,
    colorcode = color("Error"),
  },
})
