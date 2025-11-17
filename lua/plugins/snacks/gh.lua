local M = {}

M.config = {
  gh = {},
}

M.keymaps = {
  vim.keymap.set("n", "<leader>gi", function()
    Snacks.picker.gh_issue()
  end, { desc = "GitHub Issues (open)" }),

  vim.keymap.set("n", "<leader>gI", function()
    Snacks.picker.gh_issue({ state = "all" })
  end, { desc = "GitHub Issues (all)" }),

  vim.keymap.set("n", "<leader>gp", function()
    Snacks.picker.gh_pr()
  end, { desc = "GitHub Pull Requests (open)" }),

  vim.keymap.set("n", "<leader>gP", function()
    Snacks.picker.gh_pr({ state = "all" })
  end, { desc = "GitHub Pull Requests (all)" }),
}

return M
