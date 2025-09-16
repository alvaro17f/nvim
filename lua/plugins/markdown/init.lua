---@type "markview"|"render-markdown"
local plugin = "markview"

vim.g.markdown_filetypes = {
  "markdown",
}

require("plugins.markdown." .. plugin)
