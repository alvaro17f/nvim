local M = {}

local telescope = require("telescope.builtin")
local git = require("utils.git")

function M.find_files()
  local opts = {}
  if git.is_git_repo() then
    opts = {
      cwd = git.get_git_root(),
    }
  end
  telescope.find_files(opts)
end

function M.live_grep()
  local opts = {}
  if git.is_git_repo() then
    opts = {
      cwd = git.get_git_root(),
    }
  end
  telescope.live_grep(opts)
end

return M
