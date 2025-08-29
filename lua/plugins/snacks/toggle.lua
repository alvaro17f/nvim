local M = {}

local icons = require("utils.icons")

M.config = {
  toggle = {
    map = vim.keymap.set,
    which_key = true,
    notify = true,
    icon = icons.core.toggle,
    color = {
      enabled = "green",
      disabled = "yellow",
    },
  },
}

return M
