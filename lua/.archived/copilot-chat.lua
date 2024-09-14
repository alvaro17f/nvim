return {
  "CopilotC-Nvim/CopilotChat.nvim",
  cmd = "CopilotChat",
  branch = "canary",
  dependencies = {
    { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
    { "nvim-lua/plenary.nvim" },  -- for curl, log wrapper
  },
  lazy = false,
  opts = {
    debug = true, -- Enable debugging
    -- See Configuration section for rest
  },
  keys = {
    { mode = 'n', '<C-S-a>', ':CopilotChatToggle<CR>', silent = true, desc = 'Toggle Copilot Chat' },
  },
}
