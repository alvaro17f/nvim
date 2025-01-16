return {
  "snacks.nvim",
  keys = {
    {
      "<c-x>",
      function()
        Snacks.bufdelete()
      end,
      desc = "Delete buffer",
    },
  },
}
