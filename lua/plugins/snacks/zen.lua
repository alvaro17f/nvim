local M = {}

M.keymaps = {
  vim.keymap.set("n", "<leader>z", function()
    Snacks.zen()
  end, { desc = "Zen" }),
}

return M
