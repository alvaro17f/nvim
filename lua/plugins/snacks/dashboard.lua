local M = {}

local Snacks = require("snacks")

M.config = {
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
            local session = require("mini.sessions")
            local latest_session_name = session.get_latest()
            session.read(latest_session_name)
            vim.notify("Session read: " .. latest_session_name, vim.log.levels.INFO)
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
        {
          icon = "󰒲 ",
          key = "<leader>.",
          desc = " Update",
          action = function()
            require("utils").update_plugins()
          end,
        },
        { icon = " ", key = "q", desc = " Quit", action = "<CMD>qa<CR>" },
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
