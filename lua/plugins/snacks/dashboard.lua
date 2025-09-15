local M = {}

local icons = require("utils.icons").snacks.dashboard
local dashboard_utils = require("plugins.snacks.utils.dashboard")
local sessions_utils = require("plugins.mini.utils.sessions")

M.config = {
  dashboard = {
    enabled = true,
    preset = {
      keys = {
        { icon = icons.file, key = "n", desc = " New file", action = "<CMD>ene | startinsert<CR>" },
        {
          icon = icons.restore,
          key = "<backspace>",
          desc = " Restore last session",
          action = function()
            sessions_utils.restore_session()
          end,
        },
        {
          icon = icons.find,
          key = "<leader>ff",
          desc = " Find files",
          action = function()
            Snacks.dashboard.pick("files")
          end,
        },
        {
          icon = icons.grep,
          key = "<leader>fg",
          desc = " Grep text",
          action = function()
            Snacks.dashboard.pick("live_grep")
          end,
        },
        {
          icon = icons.recent,
          key = "<leader>fr",
          desc = " Recent files",
          action = function()
            Snacks.dashboard.pick("recent")
          end,
        },
        {
          icon = icons.config,
          key = "<leader>cc",
          desc = " Config",
          action = function()
            Snacks.dashboard.pick("files", { cwd = vim.fn.stdpath("config") })
          end,
        },
        {
          icon = icons.update,
          key = "<leader>.",
          desc = " Update",
          action = function()
            Pack.update()
          end,
        },
        { icon = icons.quit, key = "q", desc = " Quit", action = "<CMD>qa<CR>" },
      },
      header = dashboard_utils.get_logo(),
    },
    sections = {
      { section = "header" },
      { section = "keys", gap = 1, padding = 1 },
    },
  },
}

return M
