------------------------------------
-- UNDOFILE ON GIT REPOSITORY ONLY
------------------------------------
vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
  callback = function()
    vim.o.undofile = require("utils.git").is_git_repo()
  end,
})

------------------------------------
-- HIGHLIGHT ON YANK
------------------------------------
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ timeout = 100 })
  end,
})

------------------------------------
-- DEPENDENCIES
------------------------------------
require("utils.dependencies").missing_dependencies_notification()
