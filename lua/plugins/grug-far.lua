return {
  "MagicDuck/grug-far.nvim",
  event = { "BufReadPre", "BufNewFile" },
  --stylua: ignore
  keys = {
    { mode = "n", "<leader>r", function() require("grug-far").open() end, desc = "Search and replace" },
    { mode = "v", "<leader>r", function() require("grug-far").with_visual_selection() end, desc = "Search and replace selection" },
  },
  config = function()
    local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")

    require("grug-far").setup({
      engine = "ripgrep", -- 'astgrep'
      headerMaxWidth = 80,
      transient = true,
      prefills = {
        paths = vim.fn.expand("%"),
        filesFilter = ext and ext ~= "" and "*." .. ext or nil,
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
