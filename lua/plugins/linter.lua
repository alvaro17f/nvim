-- https://github.com/mfussenegger/nvim-lint?tab=readme-ov-file#available-linters
return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")

    lint.linters_by_ft = {
      css = { "stylelint", "biomejs" },
      javascript = { "biomejs", "eslint_d" },
      javascriptreact = { "biomejs", "eslint_d" },
      json = { "biomejs", "jsonlint" },
      scss = { "stylelint", "biomejs" },
      sh = { "shellcheck" },
      sql = { "sqruff" },
      typescript = { "biomejs", "eslint_d" },
      typescriptreact = { "biomejs", "eslint_d" },
    }

    lint.linters = {
      eslint_d = {
        args = {
          "--no-warn-ignored", -- <-- this is the key argument
          "--format",
          "json",
          "--stdin",
          "--stdin-filename",
          function()
            return vim.api.nvim_buf_get_name(0)
          end,
        },
      },
    }

    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function()
        if vim.opt_local.modifiable:get() then
          lint.try_lint()
        end
      end,
    })
  end,
}
