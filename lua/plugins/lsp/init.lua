local LSP_TOOLS = {
  "goimports",
  "kdlfmt",
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

vim.lsp.log.set_level(vim.log.levels.ERROR)

Utils.lsp.setup(LSP_TOOLS, DEBUGGERS)
