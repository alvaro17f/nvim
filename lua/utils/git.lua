local M = {}

function M.is_git_repo()
  vim.fn.system("git rev-parse --is-inside-work-tree >/dev/null 2>&1")
  return vim.v.shell_error == 0
end

function M.get_workspace_root()
  if not M.is_git_repo() then
    return vim.fn.getcwd()
  end

  local output = vim.fn.system("git rev-parse --show-toplevel 2>/dev/null")
  if vim.v.shell_error ~= 0 then
    return vim.fn.getcwd()
  end

  return output:gsub("%s*$", "")
end

return M
