local M = {}

local icons = require("utils.icons").snacks.dashboard

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
            local session = require("mini.sessions")
            local latest_session_name = session.get_latest()
            session.read(latest_session_name)
            vim.notify("Session read: " .. latest_session_name, vim.log.levels.INFO)
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
            require("utils.pack").update()
          end,
        },
        { icon = icons.quit, key = "q", desc = " Quit", action = "<CMD>qa<CR>" },
      },
      header = require("utils.snacks.dashboard").get_logo(),
    },
    sections = {
      { section = "header" },
      { section = "keys", gap = 1, padding = 1 },
    },
  },
}

return M
