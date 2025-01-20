return {
  "alvaro17f/flags.nvim",
  lazy = false,
  priority = 1000,
  keys = {
    { mode = "n", "<leader>F", "<CMD>Flags<CR>", silent = true, desc = "Open Flags" },
  },
  config = function()
    local flags = require("flags")
    flags.setup({
      icons = true,
      flags = {
        copilot = false,
        debugger = false,
      },
    })
    ------------------------------------
    vim.g.copilot = flags.get_flags("copilot") or false
    vim.g.debugger = flags.get_flags("debugger") or false
    ------------------------------------
  end,
}
