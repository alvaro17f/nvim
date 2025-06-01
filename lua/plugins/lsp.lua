local LSP_TOOLS = {
  "goimports",
  "prettier",
  "shfmt",
  "sqlfluff",
  "sql-formatter",
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
    require("utils.lsp").setup_mason(LSP_TOOLS, DEBUGGERS)
    require("utils.lsp").setup_keybindings()
    require("utils.lsp").setup_diagnostics()
    require("utils.lsp").setup_inlay_hints(false)
  end,
}
