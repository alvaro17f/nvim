------------------------------------
-- AUTOCMD
------------------------------------
vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
  desc = "Undo file on git repository only",
  callback = function()
    vim.o.undofile = require("utils.git").is_git_repo()
  end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight on yank",
  callback = function()
    vim.highlight.on_yank({ timeout = 100 })
  end,
})
