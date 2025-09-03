local LSP_TOOLS = {
  "goimports",
  "jsonlint",
  "shellcheck",
  "shfmt",
  "sqruff",
  "stylua",
}

local DEBUGGERS = {
  "codelldb",
  "delve",
  "js-debug-adapter",
}

local lsp = require("utils.lsp")

lsp.setup(LSP_TOOLS, DEBUGGERS)
