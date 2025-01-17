return {
  "snacks.nvim",
  opts = {
    dashboard = {
      enabled = true,
      preset = {
        keys = {
          { icon = " ", key = "n", desc = " New file", action = "<CMD>ene | startinsert<CR>" },
          {
            icon = " ",
            key = "<backspace>",
            desc = " Restore last session",
            action = function()
              require("persistence").load({ last = true })
            end,
          },
          {
            icon = " ",
            key = "<leader>ff",
            desc = " Find files",
            action = function()
              Snacks.dashboard.pick("files")
            end,
          },
          {
            icon = " ",
            key = "<leader>fg",
            desc = " Grep text",
            action = function()
              Snacks.dashboard.pick("live_grep")
            end,
          },
          {
            icon = " ",
            key = "<leader>fr",
            desc = " Recent files",
            action = function()
              Snacks.dashboard.pick("recent")
            end,
          },
          {
            icon = " ",
            key = "<leader>cc",
            desc = " Config",
            action = function()
              Snacks.dashboard.pick("files", { cwd = vim.fn.stdpath("config") })
            end,
          },
          { icon = "✓ ", key = "<leader>,", desc = " Mason", action = "<CMD>Mason<CR>" },
          { icon = "󰒲 ", key = "<leader>.", desc = " Lazy", action = "<CMD>Lazy sync<CR>" },
          { icon = " ", key = "q", desc = " Quit", action = "<CMD>qa<CR>" },
        },

        header = require("utils.ui").get_dashboard_header(vim.g.dashboard_header),
      },
    },
  },
}
