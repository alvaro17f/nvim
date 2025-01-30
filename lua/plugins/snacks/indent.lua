local ignored_filetypes = {
  "markdown",
}

return {
  "snacks.nvim",
  opts = {
    indent = {
      enabled = true,
      filter = function(buf)
        return require("utils.snacks.indent").is_enabled(buf, ignored_filetypes)
      end,
    },
  },
}
