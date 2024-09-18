local M = {}

local is_git_repo = require("utils.git").is_git_repo

function M.find_files()
  local status = pcall(require("telescope.builtin").git_files)
  if not status then
    require("telescope.builtin").find_files()
  end
end

function M.live_grep()
  if is_git_repo() then
    vim.cmd("Telescope git_grep live_grep")
  else
    vim.cmd("Telescope live_grep")
  end
end

return M
