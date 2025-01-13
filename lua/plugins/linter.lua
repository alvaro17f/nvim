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
      javascript = { "eslint_d", "biomejs" },
      javascriptreact = { "eslint_d", "biomejs" },
      scss = { "stylelint" },
      typescript = { "eslint_d", "biomejs" },
      typescriptreact = { "eslint_d", "biomejs" },
      sql = { "sqlfluff" },
    }

    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function()
        pcall(require, "lint.try_lint")
      end,
    })
  end,
}
