vim.pack.add({ "https://github.com/monkoose/neocodeium" }, { load = true, confirm = false })

require("neocodeium").setup({
  show_label = false,
  silent = true,
})

vim.keymap.set("i", "<Tab>", function()
  local neocodeium = require("neocodeium")
  if neocodeium.visible() then
    neocodeium.accept()
  else
    vim.api.nvim_feedkeys(vim.keycode("<Tab>"), "n", true)
  end
end, { desc = "Neocodeium: accept suggestion" })
