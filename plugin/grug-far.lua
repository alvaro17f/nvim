Pack.add({ "https://github.com/MagicDuck/grug-far.nvim" })

local grug_far = require("grug-far")

grug_far.setup({
  engine = "ripgrep", -- 'astgrep'
  headerMaxWidth = 80,
  transient = true,
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

vim.keymap.set("n", "<leader>r", function()
  grug_far.open({ prefills = { paths = vim.fn.expand("%") } })
end, { desc = "Replace" })

vim.keymap.set("v", "<leader>r", function()
  grug_far.with_visual_selection({ prefills = { paths = vim.fn.expand("%") } })
end, { desc = "Replace" })
