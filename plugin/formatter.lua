-- https://github.com/stevearc/conform.nvim?tab=readme-ov-file#formatters | :h conform-formatters
vim.pack.add({ "https://github.com/stevearc/conform.nvim" }, { load = true, confirm = false })

local conform = require("conform")

local get_cwd = function(formatter, self, ctx)
  conform.get_formatter_config(formatter, ctx.buf).cwd(self, ctx)
end

local formatters = {
  css = {
    "stylelint",
    "prettier",
    "prettierd",
    "biome",
    "biome-check",
    "biome-organize-imports",
    "eslint_d",
  },
  go = { "gofmt", "goimports" },
  lua = { "stylua" },
  nix = { "nixfmt" },
  sh = { "shfmt" },
  sql = { "sqruff" },
  typescript = {
    "prettier",
    "prettierd",
    "biome",
    "biome-check",
    "biome-organize-imports",
    "eslint_d",
  },
}

conform.setup({
  formatters_by_ft = {
    astro = formatters.typescript,
    css = formatters.css,
    go = formatters.go,
    html = formatters.typescript,
    javascript = formatters.typescript,
    javascriptreact = formatters.typescript,
    json = formatters.typescript,
    jsonc = formatters.typescript,
    lua = formatters.lua,
    nix = formatters.nix,
    scss = formatters.css,
    sh = formatters.sh,
    sql = formatters.sql,
    typescript = formatters.typescript,
    typescriptreact = formatters.typescript,
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
    ["eslint_d"] = {
      require_cwd = true,
      condition = function(self, ctx)
        return not get_cwd("biome", self, ctx) and not get_cwd("prettier", self, ctx)
      end,
    },
    ["prettier"] = {
      require_cwd = true,
      condition = function(self, ctx)
        return not get_cwd("biome", self, ctx)
      end,
    },
    ["prettierd"] = {
      require_cwd = true,
      condition = function(self, ctx)
        return not get_cwd("biome", self, ctx)
      end,
    },
    ["stylelint"] = {
      require_cwd = true,
    },
  },
  default_format_opts = { lsp_format = "fallback" },
  format_on_save = { timeout_ms = 500 },
})
