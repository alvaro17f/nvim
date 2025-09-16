Pack.add({ "https://github.com/mistweaverco/kulala.nvim" })

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "http", "rest" },
  callback = function()
    if not vim.g._kulala_loaded then
      local kulala = require("kulala")

      kulala.setup({
        global_keymaps = true,
        global_keymaps_prefix = "<leader>h",
      })

      vim.g._kulala_loaded = true
    end
  end,
})
