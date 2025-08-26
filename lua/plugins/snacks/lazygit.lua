local M = {}

M.config = {
  lazygit = {
    enabled = true,
    win = {
      style = {
        width = 0,
        height = 0,
      },
    },
  },
}

M.keymaps = {
  vim.keymap.set("n", "<leader>gg", function()
    if require("utils.git").is_git_repo() then
      Snacks.lazygit({ cwd = require("utils.git").get_workspace_root() })
    elseif vim.bo.filetype == "snacks_dashboard" then
      Snacks.lazygit({ cwd = vim.fn.stdpath("config") })
    else
      print("You're not in a git repository")
    end
  end, { desc = "Lazygit" }),
}

vim.keymap.set("n", "<leader>gl", function()
  if require("utils.git").is_git_repo() then
    Snacks.lazygit.log({ cwd = require("utils.git").get_workspace_root() })
  elseif vim.bo.filetype == "snacks_dashboard" then
    Snacks.lazygit.log({ cwd = vim.fn.stdpath("config") })
  else
    print("You're not in a git repository")
  end
end, { desc = "Lazygit log" })

vim.keymap.set("n", "<leader>gh", function()
  if require("utils.git").is_git_repo() then
    Snacks.lazygit.log_file()
  else
    print("You're not in a git repository")
  end
end, { desc = "Lazygit file history" })

return M
