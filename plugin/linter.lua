-- https://github.com/mfussenegger/nvim-lint?tab=readme-ov-file#available-linters
Pack.add({ "https://github.com/mfussenegger/nvim-lint" })

local lint = require("lint")

lint.linters_by_ft = {
  json = { "biomejs" },
  sh = { "shellcheck" },
  sql = { "sqruff" },
}

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave", "TextChanged" }, {
  callback = function()
    if vim.opt_local.modifiable:get() then
      lint.try_lint(nil, { ignore_errors = true })
    end
  end,
})
