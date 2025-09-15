local M = {}

local ignored_filetypes = {
  "markdown",
}

M.config = {
  indent = {
    enabled = true,
    filter = function(buf)
      return Utils.snacks.indent.is_enabled(buf, ignored_filetypes)
    end,
  },
}

return M
