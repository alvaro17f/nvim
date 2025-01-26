return {
  "snacks.nvim",
  keys = {
    {
      "-",
      function()
        require("utils.snacks.scratch").new_scratch()
      end,
      desc = "Toggle Scratch Buffer",
    },
    {
      "_",
      function()
        require("utils.snacks.scratch").select_scratch()
      end,
      desc = "Select Scratch Buffer",
    },
  },
}
