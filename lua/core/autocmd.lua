------------------------------------
--FLAGS
------------------------------------
require("utils.flags").generate_flags_fn()

------------------------------------
--SINGLE DIAGNOSTIC ICON
------------------------------------
require("utils.lsp").override_diagnostic_signs_handler()

------------------------------------
--GOLANG ORGANIZE IMPORTS
------------------------------------
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    vim.lsp.buf.code_action({
      context = { only = { "source.organizeImports" } },
      apply = true,
    })
  end,
})

------------------------------------
--UNDOFILE ON GIT REPOSITORY ONLY
------------------------------------
vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
  callback = function()
    vim.opt.undofile = require("utils.git").is_git_repo()
  end,
})

------------------------------------
--DEPENDENCIES
------------------------------------
require("utils.dependencies").missing_dependencies_notification()
