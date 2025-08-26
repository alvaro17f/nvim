vim.pack.add({ "https://github.com/OXY2DEV/helpview.nvim" }, { load = true, confirm = false })

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "help",
  callback = function()
    require("helpview").setup()
  end,
})
