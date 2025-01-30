local M = {}

M.headers = {
  anonymous = "anonymous.cat",
  eagle = "eagle.cat",
  neovim = "neovim.cat",
}

local function get_header(header)
  return vim.fn.readfile(vim.fn.stdpath("config") .. "/assets/dashboard/" .. header)
end

function M.get_dashboard_header(header)
  return table.concat(get_header(header), "\n")
end

return M
