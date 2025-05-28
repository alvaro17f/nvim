-- https://github.com/stevearc/conform.nvim?tab=readme-ov-file#formatters | :h conform-formatters
return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("conform").setup({
      formatters_by_ft = {
        css = { "prettier" },
        go = { "gofmt", "goimports", stop_after_first = false },
        html = { "prettier" },
        javascript = { "prettier" },
        javascriptreact = { "prettier" },
        json = { "prettier" },
        lua = { "stylua" },
        markdown = { "prettier" },
        nix = { "nixfmt" },
        odin = { "odinfmt" },
        rust = { "rustfmt" },
        scss = { "prettier" },
        sh = { "shfmt" },
        sql = { "sql_formatter" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        zig = { "zigfmt" },
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
