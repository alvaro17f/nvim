return {
  "folke/persistence.nvim",
  event = "BufReadPre",
  keys = {
    {
      "<leader>ww",
      function()
        require("persistence").select()
      end,
      desc = "Select session",
    },
    {
      "<leader>ws",
      function()
        require("persistence").save()
      end,
      desc = "Save session",
    },
    {
      "<leader>w<backspace>",
      function()
        require("persistence").load({ last = true })
      end,
      desc = "Load last session",
    },
  },
  opts = {
    options = vim.opt.sessionoptions:get(),

    vim.api.nvim_create_autocmd("User", {
      pattern = "PersistenceSavePre",
      callback = function()
        require("edgy").close()
        require("dapui").close()
      end,
    }),
  },
}
