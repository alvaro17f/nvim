--TODO:
local ui = require("utils.ui")
local function get_dashboard_header(header)
  return table.concat(ui.get_header(header), "\n")
end

local header = ui.headers.neovim

return {
  "snacks.nvim",
  opts = {
    dashboard = {
      enabled = true,
      preset = {
        keys = {
          { icon = " ", key = "n", desc = " New file", action = ":ene | startinsert" },
          {
            icon = " ",
            key = "<leader>ww",
            desc = " Restore session",
            action = ":lua require('nvim-possession').list()",
          },
          { icon = " ", key = "<leader>ff", desc = " Find files", action = ":lua Snacks.dashboard.pick('files')" },
          {
            icon = " ",
            key = "<leader>fg",
            desc = " Grep text",
            action = ":lua Snacks.dashboard.pick('live_grep')",
          },
          {
            icon = " ",
            key = "<leader>fr",
            desc = " Recent files",
            action = ":lua Snacks.dashboard.pick('oldfiles')",
          },
          {
            icon = " ",
            key = "<leader>cc",
            desc = " Config",
            action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
          },
          { icon = "✓ ", key = "<leader>,", desc = " Mason", action = ":Mason" },
          { icon = "󰒲 ", key = "<leader>.", desc = " Lazy", action = ":Lazy sync" },
          { icon = " ", key = "q", desc = " Quit", action = ":qa" },
        },

        header = get_dashboard_header(header),
      },
    },
  },
}
