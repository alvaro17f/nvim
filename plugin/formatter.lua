-- https://github.com/stevearc/conform.nvim?tab=readme-ov-file#formatters | :h conform-formatters
vim.pack.add({ "https://github.com/stevearc/conform.nvim" }, { load = true, confirm = false })

local conform = require("conform")

local formatters = {
  frontend = {
    "prettier",
    "prettierd",
    "biome",
    "biome-check",
    "biome-organize-imports",
  },
  go = { "gofmt", "goimports" },
  http = { "kulala-fmt" },
  lua = { "stylua" },
  nix = { "nixfmt" },
  sh = { "shfmt" },
  sql = { "sqruff" },
}

conform.setup({
  formatters_by_ft = {
    astro = formatters.frontend,
    css = formatters.frontend,
    go = formatters.go,
    html = formatters.frontend,
    http = formatters.http,
    javascript = formatters.frontend,
    javascriptreact = formatters.frontend,
    json = formatters.frontend,
    jsonc = formatters.frontend,
    lua = formatters.lua,
    nix = formatters.nix,
    scss = formatters.frontend,
    sh = formatters.sh,
    sql = formatters.sql,
    typescript = formatters.frontend,
    typescriptreact = formatters.frontend,
    -- ["_"] = { "trim_newlines", "trim_whitespace" },
  },
  formatters = {
    ["biome"] = {
      require_cwd = true,
    },
    ["biome-check"] = {
      require_cwd = true,
    },
    ["biome-organize-imports"] = {
      require_cwd = true,
    },
    ["prettier"] = {
      require_cwd = true,
      condition = function(self, ctx)
        return not conform.get_formatter_config("biome", ctx.buf).cwd(self, ctx)
      end,
    },
    ["prettierd"] = {
      require_cwd = true,
      condition = function(self, ctx)
        return not conform.get_formatter_config("biome", ctx.buf).cwd(self, ctx)
      end,
    },
  },
  default_format_opts = { lsp_format = "fallback" },
  format_on_save = { timeout_ms = 500 },
})
