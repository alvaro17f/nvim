-- https://github.com/stevearc/conform.nvim?tab=readme-ov-file#formatters | :h conform-formatters
local formatter = require("utils.formmatter")
return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("conform").setup({
      formatters_by_ft = {
        css = formatter.css(),
        go = { "gofmt", "goimports", stop_after_first = false },
        html = formatter.typescript(),
        javascript = formatter.typescript(),
        javascriptreact = formatter.typescript(),
        json = formatter.typescript(),
        lua = { "stylua" },
        markdown = formatter.typescript(),
        nix = { "nixfmt" },
        odin = { "odinfmt" },
        rust = { "rustfmt" },
        scss = formatter.css(),
        sh = { "shfmt" },
        sql = { "sql_formatter" },
        typescript = formatter.typescript(),
        typescriptreact = formatter.typescript(),
        zig = { "zigfmt" },
        ["*"] = { "trim_newlines", "trim_whitespace" },
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
