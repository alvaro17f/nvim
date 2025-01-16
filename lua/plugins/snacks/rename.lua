return {
  "snacks.nvim",
  keys = {
    {
      "<leader>R",
      function()
        Snacks.rename.rename_file()
      end,
      desc = "Rename file",
    },
  },
}
