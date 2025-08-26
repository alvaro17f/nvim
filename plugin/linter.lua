-- https://github.com/mfussenegger/nvim-lint?tab=readme-ov-file#available-linters
vim.pack.add({ "https://github.com/mfussenegger/nvim-lint" }, { load = true, confirm = false })

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

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
  callback = function()
    if vim.opt_local.modifiable:get() then
      lint.try_lint()
    end
  end,
})
