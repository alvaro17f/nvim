-- https://github.com/mfussenegger/nvim-lint?tab=readme-ov-file#available-linters
return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")

    lint.linters_by_ft = {
      css = { "stylelint", "biomejs" },
      javascript = { "biomejs" },
      javascriptreact = { "biomejs" },
      json = { "biomejs", "jsonlint" },
      scss = { "stylelint", "biomejs" },
      sh = { "shellcheck" },
      sql = { "sqruff" },
      typescript = { "biomejs" },
      typescriptreact = { "biomejs" },
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
