Pack.add({ "https://github.com/windwp/nvim-autopairs" })

vim.api.nvim_create_autocmd("InsertEnter", {
  callback = function()
    local autopairs = require("nvim-autopairs")

    autopairs.setup({
      check_ts = true,
      map_bs = false,
    })
  end,
})
