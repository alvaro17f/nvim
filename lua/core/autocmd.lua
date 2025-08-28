------------------------------------
-- AUTOCMD
------------------------------------
require("utils.autosave")

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight on yank",
  callback = function()
    vim.hl.on_yank()
  end,
})
