return {
  "monkoose/neocodeium",
  event = { "VeryLazy" },
  keys = {
    {
      mode = "i",
      "<Tab>",
      function()
        local neocodeium = require("neocodeium")
        if neocodeium.visible() then
          neocodeium.accept()
        else
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", true)
        end
      end,
      desc = "Neocodeium: accept suggestion",
    },
  },
  opts = {
    show_label = false,
  },
}
