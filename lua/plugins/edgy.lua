return {
  "folke/edgy.nvim",
  event = { "VeryLazy" },
  init = function()
    vim.o.laststatus = 3
    vim.o.splitkeep = "screen"
  end,
  opts = {
    top = {},
    right = {
      { ft = "codecompanion", title = "CodeCompanion", size = { width = 0.5 } },
      { ft = "grug-far", title = "Search & Replace", size = { width = 0.5 } },
      { ft = "neotest-summary", title = "neotest", size = { width = 0.3 } },
      { ft = "Outline", title = "Outline", size = { width = 0.2 } },
    },
    bottom = {
      {
        ft = "help",
        size = { height = 0.7 },
        filter = function(buf)
          return vim.bo[buf].buftype == "help"
        end,
      },
      { ft = "neotest-output-panel", title = "neotest", size = { height = 0.5 } },
      { ft = "qf", title = "QuickFix" },
      {
        ft = "snacks_terminal",
        size = { height = 0.5 },
        title = "Terminal %{b:snacks_terminal.id}",
        filter = function(_, win)
          return vim.w[win].snacks_win
            and vim.w[win].snacks_win.position == "bottom"
            and vim.w[win].snacks_win.relative == "editor"
            and not vim.w[win].trouble_preview
        end,
      },
      { ft = "trouble", title = "Trouble", size = { height = 0.4 } },
    },
    left = {},

    animate = { enabled = false },
    options = {
      top = { size = 10 },
    },
    wo = { winhighlight = "" },
  },
}
