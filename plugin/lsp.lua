local LSP_TOOLS = {
  "eslint_d",
  "goimports",
  "jsonlint",
  "prettier",
  "shellcheck",
  "shfmt",
  "sqruff",
  "stylelint",
  "stylua",
}

local DEBUGGERS = {
  "codelldb",
  "delve",
  "js-debug-adapter",
}

local lsp = require("utils.lsp")

lsp.setup(LSP_TOOLS, DEBUGGERS)
