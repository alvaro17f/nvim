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

Utils.lsp.setup(LSP_TOOLS, DEBUGGERS)
