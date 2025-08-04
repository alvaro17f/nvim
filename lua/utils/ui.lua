local M = {}

local logos_path = vim.fn.stdpath("config") .. "/assets/logos/"

function M.get_logo()
  local success, logo = pcall(vim.fn.readfile, logos_path .. vim.g.logo)
  return success and table.concat(logo, "\n") or ""
end

return M
