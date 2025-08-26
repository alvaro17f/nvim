local M = {}

M.config = {
  toggle = {
    map = vim.keymap.set,
    which_key = true,
    notify = true,
    icon = {
      enabled = " ",
      disabled = " ",
    },
    color = {
      enabled = "green",
      disabled = "yellow",
    },
  },
}

return M
