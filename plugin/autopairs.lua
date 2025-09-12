Pack.add({ "https://github.com/windwp/nvim-autopairs" })

vim.api.nvim_create_autocmd("InsertEnter", {
  callback = function()
    require("nvim-autopairs").setup()
  end,
})
