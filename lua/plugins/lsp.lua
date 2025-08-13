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

return {
  "neovim/nvim-lspconfig",
  dependencies = {
    {
      "mason-org/mason.nvim",
      opts = {
        ui = {
          icons = {
            package_installed = "",
            package_pending = "",
            package_uninstalled = "",
          },
        },
      },
      keys = {
        { mode = "n", "<leader>,", "<CMD>Mason<CR>", desc = "Open mason" },
      },
    },
    { "mason-org/mason-lspconfig.nvim" },
    { "WhoIsSethDaniel/mason-tool-installer.nvim" },
  },
  config = function()
    local lsp_utils = require("utils.lsp")

    lsp_utils.setup_mason(LSP_TOOLS, DEBUGGERS)
    lsp_utils.setup_keybindings()
    lsp_utils.setup_diagnostics()
    lsp_utils.setup_inlay_hints(false)
    lsp_utils.setup_colors()
  end,
}
