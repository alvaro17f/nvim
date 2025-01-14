-- https://github.com/stevearc/conform.nvim?tab=readme-ov-file#formatters | :h conform-formatters
return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("conform").setup({
      formatters_by_ft = {
        css = { "prettierd", "prettier", "biome" },
        go = { "gofmt", "goimports", stop_after_first = false },
        html = { "prettierd", "prettier", "biome" },
        javascript = { "prettierd", "prettier", "biome" },
        javascriptreact = { "prettierd", "prettier", "biome" },
        json = { "prettierd", "prettier", "biome" },
        lua = { "stylua" },
        markdown = { "prettierd", "prettier", "biome" },
        nix = { "nixfmt" },
        scss = { "prettierd", "prettier", "biome" },
        sh = { "shfmt" },
        sql = { "sql_formatter" },
        typescript = { "prettierd", "prettier", "biome" },
        typescriptreact = { "prettierd", "prettier", "biome" },
        ["*"] = { "trim_whitespace" },
      },
      default_format_opts = {
        lsp_format = "fallback",
        stop_after_first = true,
        quiet = true,
      },
      format_on_save = {
        lsp_format = "fallback",
        timeout_ms = 500,
      },
    })
  end,
}
