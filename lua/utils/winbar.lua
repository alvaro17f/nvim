local M = {}

local function get_icon(filename)
  filename = filename or vim.fn.expand("%:t")
  local extension = vim.fn.fnamemodify(filename, ":e")
  return require("nvim-web-devicons").get_icon(filename, extension, { default = true })
end

function M.winbar_get_icon()
  local file_icon, hl_group = get_icon()
  if not file_icon then
    return ""
  end
  if not hl_group then
    return file_icon
  end
  return "%#" .. hl_group .. "#" .. file_icon .. "%*"
end

return M
