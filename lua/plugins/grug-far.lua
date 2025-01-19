return {
  "MagicDuck/grug-far.nvim",
  event = { "BufReadPre", "BufNewFile" },
  keys = {
    {
      mode = { "n", "v" },
      "<leader>r",
      function()
        require("grug-far").with_visual_selection()
      end,
      desc = "Search and replace",
    },
  },
  config = function()
    require("grug-far").setup({
      engine = "ripgrep", -- 'astgrep'
      prefills = {
        paths = vim.fn.expand("%"),
      },
      keymaps = {
        replace = { n = "<localleader><enter>" },
        qflist = { n = "<c-q>" },
        syncLocations = { n = "<localleader>s" },
        syncLine = { n = "<localleader>l" },
        close = { n = "q" },
        historyOpen = { n = "<localleader>t" },
        historyAdd = { n = "<localleader>a" },
        refresh = { n = "<localleader>f" },
        openLocation = { n = "<localleader>o" },
        openNextLocation = { n = "<down>" },
        openPrevLocation = { n = "<up>" },
        gotoLocation = { n = "<enter>" },
        pickHistoryEntry = { n = "<enter>" },
        abort = { n = "<localleader>b" },
        help = { n = "g?" },
        toggleShowCommand = { n = "<localleader>p" },
        swapEngine = { n = "<localleader>e" },
        previewLocation = { n = "<localleader>i" },
      },
    })
  end,
}
