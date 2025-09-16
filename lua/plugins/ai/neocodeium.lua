Pack.add({ "https://github.com/monkoose/neocodeium" })

local neocodeium = require("neocodeium")

neocodeium.setup({
  show_label = false,
  silent = true,
})

vim.keymap.set("i", "<Tab>", function()
  if neocodeium.visible() then
    neocodeium.accept()
  else
    vim.api.nvim_feedkeys(vim.keycode("<Tab>"), "n", true)
  end
end, { desc = "Neocodeium: accept suggestion" })
