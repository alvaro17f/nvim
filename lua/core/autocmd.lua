------------------------------------
-- AUTOCMD
------------------------------------
vim.api.nvim_create_autocmd({ "InsertLeavePre", "TextChanged", "TextChangedP" }, {
  desc = "Auto save",
  callback = function()
    if vim.g.autosave and vim.bo.modifiable and vim.bo.modified then
      vim.defer_fn(function()
        vim.cmd("silent! write")
        print("󰄳 auto-save: saved at " .. vim.fn.strftime("%H:%M:%S"))
      end, 1000)
    end
  end,
})

vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
  desc = "Undo file on git repository only",
  callback = function()
    vim.o.undofile = require("utils.git").is_git_repo()
  end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight on yank",
  callback = function()
    vim.hl.on_yank()
  end,
})
