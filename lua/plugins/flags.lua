return {
  "alvaro17f/flags.nvim",
  keys = {
    { mode = "n", "<leader>F", "<CMD>Flags<CR>", silent = true, desc = "Open Flags" },
  },
  opts = {
    icons = true,
    flags = {
      copilot = false,
      debugger = false,
    },
  },
}
