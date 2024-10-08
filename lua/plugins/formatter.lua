-- https://github.com/stevearc/conform.nvim?tab=readme-ov-file#formatters | :h conform-formatters
return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("conform").setup({
      formatters_by_ft = {
        css = { "prettierd", "prettier", "ast-grep" },
        go = { "gofmt", "goimports", stop_after_first = false },
        html = { "prettierd", "prettier", "ast-grep" },
        javascript = { "prettierd", "prettier", "ast-grep" },
        javascriptreact = { "prettierd", "prettier", "ast-grep" },
        json = { "prettierd", "prettier", "ast-grep" },
        lua = { "stylua" },
        markdown = { "prettierd", "prettier", "ast-grep" },
        nix = { "nixfmt" },
        scss = { "prettierd", "prettier", "ast-grep" },
        sh = { "shfmt" },
        typescript = { "prettierd", "prettier", "ast-grep" },
        typescriptreact = { "prettierd", "prettier", "ast-grep" },
      },
      default_format_opts = {
        lsp_format = "fallback",
        stop_after_first = true,
      },
      format_on_save = {
        lsp_fallback = true,
        async = false,
        timeout_ms = 500,
      },
    })
  end,
}
