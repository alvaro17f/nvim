vim.pack.add({ "https://github.com/windwp/nvim-autopairs" }, { load = true, confirm = false })

vim.api.nvim_create_autocmd("InsertEnter", {
  callback = function()
    require("nvim-autopairs").setup()
  end,
})
