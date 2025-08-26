local M = {}

local ignored_filetypes = {
  "markdown",
}

M.config = {
  indent = {
    enabled = true,
    filter = function(buf)
      return require("utils.snacks.indent").is_enabled(buf, ignored_filetypes)
    end,
  },
}

return M
