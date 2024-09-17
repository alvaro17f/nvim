local is_git_repo = require("utils.is_git_repo")

local function find_files()
  local status = pcall(require("telescope.builtin").git_files)
  if not status then
    require("telescope.builtin").find_files()
  end
end

local function live_grep()
  if is_git_repo() then
    vim.cmd("Telescope git_grep live_grep")
  else
    vim.cmd("Telescope live_grep")
  end
end

return {
  find_files = find_files,
  live_grep = live_grep,
}
