local LSP_TOOLS = {
  "goimports",
  "kulala-fmt",
  "shellcheck",
  "shfmt",
  "sqruff",
  "stylua",
  "typstyle",
}

local DEBUGGERS = {
  "codelldb",
  "delve",
  "js-debug-adapter",
}

local lsp = require("utils.lsp")

lsp.setup(LSP_TOOLS, DEBUGGERS)
