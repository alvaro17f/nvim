vim.pack.add({ "https://github.com/neovim/nvim-lspconfig" }, { load = true, confirm = false })

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

local lsp_utils = require("utils.lsp")

lsp_utils.setup_lsp(LSP_TOOLS, DEBUGGERS)
lsp_utils.setup_keybindings()
lsp_utils.setup_diagnostics()
lsp_utils.setup_inlay_hints(false)
lsp_utils.setup_colors()
