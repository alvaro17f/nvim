local M = {}

local logos_path = vim.fn.stdpath("config") .. "/assets/dashboard/"

function M.get_logos()
  local logos = {}
  for _, logo in pairs(vim.fn.readdir(logos_path)) do
    table.insert(logos, logo)
  end

  return logos
end

function M.get_logo()
  if not vim.tbl_contains(M.get_logos(), vim.g.logo) then
    return ""
  end

  return table.concat(vim.fn.readfile(logos_path .. vim.g.logo), "\n")
end

return M
