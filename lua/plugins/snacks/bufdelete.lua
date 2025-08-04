return {
  "snacks.nvim",
  keys = {
    {
      "<c-c>",
      function()
        Snacks.bufdelete()
      end,
      desc = "Delete buffer",
    },
  },
}
