---@diagnostic disable: undefined-global

local ui = require("utils.ui")
local function get_dashboard_header(header)
  return table.concat(ui.get_header(header), "\n")
end

local header = ui.headers.neovim

return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  keys = {
    {
      mode = { "n", "t" },
      "<C-\\>",
      function()
        Snacks.terminal.toggle()
      end,
      silent = true,
      desc = "Toggle terminal",
    },
    {
      "<c-_>",
      function()
        Snacks.terminal()
      end,
      desc = "which_key_ignore",
    },
    {
      "<c-x>",
      function()
        Snacks.bufdelete()
      end,
      desc = "Delete buffer",
    },
    {
      "<leader>R",
      function()
        Snacks.rename.rename_file()
      end,
      desc = "Rename file",
    },
    {
      "<leader>gB",
      function()
        Snacks.gitbrowse()
      end,
      desc = "Git browse",
      mode = { "n", "v" },
    },
    {
      "<leader>gg",
      function()
        if require("utils.git").is_git_repo() then
          Snacks.lazygit({ cwd = require("utils.git").get_git_root() })
        elseif vim.bo.filetype == "snacks_dashboard" then
          Snacks.lazygit({ cwd = vim.fn.stdpath("config") })
        end
      end,
      desc = "Lazygit",
    },
    {
      "<leader>gl",
      function()
        if require("utils.git").is_git_repo() then
          Snacks.lazygit.log({ cwd = require("utils.git").get_git_root() })
        elseif vim.bo.filetype == "snacks_dashboard" then
          Snacks.lazygit.log({ cwd = vim.fn.stdpath("config") })
        end
      end,
      desc = "Lazygit log",
    },
    {
      "<leader>nn",
      function()
        Snacks.notifier.show_history()
      end,
      desc = "Notification history",
    },
    {
      "<leader>nd",
      function()
        Snacks.notifier.hide()
      end,
      desc = "Dismiss all notifications",
    },
    {
      "<leader>z",
      function()
        Snacks.zen()
      end,
      desc = "Toggle zen mode",
    },
    {
      "[[",
      function()
        Snacks.words.jump(-vim.v.count1)
      end,
      desc = "Prev Reference",
      mode = { "n", "t" },
    },
    {
      "]]",
      function()
        Snacks.words.jump(vim.v.count1)
      end,
      desc = "Next reference",
      mode = { "n", "t" },
    },
    {
      "<leader>\\",
      function()
        Snacks.scratch()
      end,
      desc = "Toggle Scratch Buffer",
    },
    {
      "<leader>|",
      function()
        require("utils.fzf").scratch_buffers()
      end,
      desc = "Select Scratch Buffer",
    },
    {
      "<leader>N",
      desc = "Neovim news",
      function()
        Snacks.win({
          file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
          width = 0.6,
          height = 0.6,
          wo = {
            spell = false,
            wrap = false,
            signcolumn = "yes",
            statuscolumn = " ",
            conceallevel = 3,
          },
        })
      end,
    },
  },

  opts = {
    bigfile = { enabled = true },
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
    debug = { enabled = true },
    dim = { enabled = true },
    indent = { enabled = true },
    input = { enabled = true },
    lazygit = {
      enabled = true,
      win = {
        style = {
          width = 0,
          height = 0,
        },
      },
    },
    notifier = {
      enabled = true,
      top_down = false,
      style = "minimal", -- "compact" | "fancy" | "minimal"
    },
    notify = { enabled = true },
    quickfile = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
    terminal = {
      enabled = true,
      win = {
        keys = {
          term_normal = {
            "<esc><esc>",
            function()
              return "<C-\\><C-n>"
            end,
            mode = "t",
            expr = true,
            desc = "Double escape to normal mode",
          },
          q = "hide",
          ["<esc>"] = "hide",
        },
      },
    },
    words = { enabled = true },
    win = { wo = { winhighlight = "" } },
  },
}
