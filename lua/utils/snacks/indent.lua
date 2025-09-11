local M = {}

local is_ignored_filetype = function(ignored_filetypes, filetype)
  return vim.tbl_contains(ignored_filetypes, filetype)
end

M.is_enabled = function(buf, ignored_filetypes)
  return not is_ignored_filetype(ignored_filetypes, vim.bo[buf].filetype)
    and vim.g.snacks_indent ~= false
    and vim.b[buf].snacks_indent ~= false
    and vim.bo[buf].buftype == ""
end

return M
