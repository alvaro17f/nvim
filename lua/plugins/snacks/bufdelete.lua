local M = {}

M.keymaps = {
  vim.keymap.set("n", "<c-c>", function()
    Snacks.bufdelete()
  end, { desc = "Close buffer" }),
}

return M
