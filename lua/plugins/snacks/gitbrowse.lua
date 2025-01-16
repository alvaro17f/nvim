return {
  "snacks.nvim",
  keys = {
    {
      "<leader>gB",
      function()
        Snacks.gitbrowse()
      end,
      desc = "Git browse",
      mode = { "n", "v" },
    },
  },
}
