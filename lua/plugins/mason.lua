-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md

local LSP_SERVERS = {
  "astro",
  "bashls",
  "biome",
  "cssls",
  "docker_compose_language_service",
  "dockerls",
  "emmet_ls",
  "gopls",
  "html",
  "jsonls",
  "nil_ls",
  "rust_analyzer",
  "sqlls",
  "lua_ls",
  "ols",
  "taplo",
  "ts_ls",
  "tailwindcss",
  "yamlls",
  "zls",
}

local LSP_TOOLS = {
  "eslint_d",
  "jq",
  "prettierd",
  "stylua",
}

return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")
    local mason_tool_installer = require("mason-tool-installer")

    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    mason_lspconfig.setup({
      auto_install = true,
      ensure_installed = LSP_SERVERS,
    })

    mason_tool_installer.setup({
      ensure_installed = LSP_TOOLS,
    })
  end,
}
