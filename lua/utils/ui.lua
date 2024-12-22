local M = {}

M.headers = {
  eagle = "eagle.cat",
  neovim = "neovim.cat",
}

function M.get_header(header)
  return vim.fn.readfile(vim.fn.stdpath("config") .. "/static/header/" .. header)
end

return M
