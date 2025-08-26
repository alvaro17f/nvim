local M = {}

M.keymaps = {
  vim.keymap.set({ "n", "v", "x" }, "<leader>gB", function()
    Snacks.gitbrowse()
  end, { desc = "Git Browse" }),
}

return M
