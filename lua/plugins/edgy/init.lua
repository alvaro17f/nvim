Pack.add({ "https://github.com/folke/edgy.nvim" })

vim.o.laststatus = 3
vim.o.splitkeep = "screen"

local edgy = require("edgy")

edgy.setup({
  top = {},
  right = {
    {
      title = "Search & Replace",
      ft = "grug-far",
      size = { width = 0.5 },
    },
    {
      title = "Neotest",
      ft = "neotest-summary",
      size = { width = 0.3 },
    },
    {
      title = "AI Chat",
      ft = "ai_chat",
      size = { width = 0.4 },
      wo = { winbar = false },
    },
  },
  bottom = {
    {
      title = "Help",
      ft = "help",
      size = { height = 0.7 },
      filter = function(buf)
        return vim.bo[buf].buftype == "help"
      end,
    },
    {
      title = "Neotest",
      ft = "neotest-output-panel",
      size = { height = 0.5 },
    },
    {
      title = "QuickFix",
      ft = "qf",
    },
    {
      title = "Terminal %{b:snacks_terminal.id}",
      ft = "snacks_terminal",
      size = { height = 0.5 },
      filter = function(_, win)
        return vim.w[win].snacks_win
          and vim.w[win].snacks_win.position == "bottom"
          and vim.w[win].snacks_win.relative == "editor"
          and not vim.w[win].trouble_preview
      end,
    },
    {
      title = "Trouble",
      ft = "trouble",
    },
  },
  left = {
    {
      title = "Explorer",
      ft = "snacks_layout_box",
      size = { width = 0.25 },
      filter = function(_, win)
        return vim.api.nvim_win_get_config(win).relative == ""
      end,
    },
  },

  animate = {
    enabled = false,
  },
  options = {
    top = { size = 10 },
  },
  wo = {
    winbar = true,
  },
})
