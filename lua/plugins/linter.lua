-- https://github.com/mfussenegger/nvim-lint?tab=readme-ov-file#available-linters
return {
  "mfussenegger/nvim-lint",
  event = {
    "BufReadPre",
    "BufNewFile",
  },
  config = function()
    local lint = require("lint")

    lint.linters_by_ft = {
      css = { "stylelint" },
      javascript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      scss = { "stylelint" },
      typescript = { "eslint_d" },
      typescriptreact = { "eslint_d" },
    }

    lint.linters = {
      astro = {
        cmd = "astro_ls",
        stdin = true,
      },
    }

    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function()
        lint.try_lint()
      end,
    })
  end,
}
