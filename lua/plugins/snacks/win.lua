return {
  "snacks.nvim",
  keys = {
    {
      "<leader>N",
      desc = "Neovim news",
      function()
        Snacks.win({
          file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
          width = 0.6,
          height = 0.6,
          wo = {
            spell = false,
            wrap = false,
            signcolumn = "yes",
            statuscolumn = " ",
            conceallevel = 3,
          },
        })
      end,
    },
  },
  opts = {
    win = {
      wo = { winhighlight = "" },
    },
  },
}
