------------------------------------
--FLAGS
------------------------------------
require("utils.flags").generate_flags_fn()

------------------------------------
--UNDOFILE ON GIT REPOSITORY ONLY
------------------------------------
vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
  callback = function()
    vim.o.undofile = require("utils.git").is_git_repo()
  end,
})

------------------------------------
--HIGHLIGHT ON YANK
------------------------------------
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

------------------------------------
--DEPENDENCIES
------------------------------------
require("utils.dependencies").missing_dependencies_notification()

------------------------------------
--SNIPPETS
------------------------------------
require("utils.snippets")
