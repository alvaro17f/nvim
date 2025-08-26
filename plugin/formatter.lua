-- https://github.com/stevearc/conform.nvim?tab=readme-ov-file#formatters | :h conform-formatters

vim.pack.add({ "https://github.com/stevearc/conform.nvim" }, { load = true, confirm = false })

local formatters = require("utils.formatter")
require("conform").setup({
  formatters_by_ft = {
    css = formatters.css(),
    go = { "gofmt", "goimports" },
    html = formatters.typescript(),
    javascript = formatters.typescript(),
    javascriptreact = formatters.typescript(),
    json = formatters.typescript(),
    lua = { "stylua" },
    nix = { "nixfmt" },
    odin = { "odinfmt" },
    rust = { "rustfmt" },
    scss = formatters.css(),
    sh = { "shfmt" },
    sql = { "sqruff" },
    typescript = formatters.typescript(),
    typescriptreact = formatters.typescript(),
    zig = { "zigfmt" },
    ["*"] = { "trim_newlines", "trim_whitespace" },
  },
  default_format_opts = {
    lsp_format = "fallback",
    quiet = true,
  },
  format_on_save = {
    lsp_format = "fallback",
    timeout_ms = 500,
  },
})
