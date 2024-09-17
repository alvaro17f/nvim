return {
  "soulis-1256/eagle.nvim",
  config = function()
    require("eagle").setup()
    vim.o.mousemoveevent = true
  end,
}
