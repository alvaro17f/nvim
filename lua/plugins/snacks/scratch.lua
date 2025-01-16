return {
  "snacks.nvim",
  keys = {
    {
      "-",
      function()
        Snacks.scratch()
      end,
      desc = "Toggle Scratch Buffer",
    },
    {
      "_",
      function()
        require("utils.fzf").scratch_buffers()
      end,
      desc = "Select Scratch Buffer",
    },
  },
}
