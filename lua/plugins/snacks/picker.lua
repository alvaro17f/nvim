return {
  "snacks.nvim",
  keys = {
    {
      "<leader>ff",
      function()
        if require("utils.git").is_git_repo() then
          return Snacks.picker.git_files({ cwd = require("utils.git").get_workspace_root() })
        end

        Snacks.picker.files({ cwd = require("utils.git").get_workspace_root() })
      end,
      desc = "Find files",
    },
    {
      "<leader>fg",
      function()
        Snacks.picker.grep({ cwd = require("utils.git").get_workspace_root() })
      end,
      desc = "Grep",
    },
    {
      "<leader>fr",
      function()
        Snacks.picker.recent()
      end,
      desc = "Recent",
    },
    {
      "<leader>fs",
      function()
        Snacks.picker.smart()
      end,
      desc = "Smart",
    },
    {
      "<leader>fh",
      function()
        Snacks.picker.help()
      end,
      desc = "Help Pages",
    },
    {
      "<leader>fb",
      function()
        Snacks.picker.grep_buffers()
      end,
      desc = "Grep Open Buffers",
    },
    {

      "<leader><leader>",
      function()
        Snacks.picker.buffers()
      end,
      desc = "Buffers",
    },
    {
      "<leader>cc",
      function()
        Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
      end,
      desc = "Find config files",
    },
    {
      "<leader>f<backspace>",
      function()
        Snacks.picker.resume()
      end,
      desc = "Resume",
    },
    {
      "<leader>fP",
      function()
        Snacks.picker.pickers()
      end,
      desc = "Pickers",
    },
    {
      "<leader>fp",
      function()
        Snacks.picker.projects()
      end,
      desc = "Projects",
    },
  },
  opts = {
    picker = {
      layout = {
        preset = "default", -- "default", "dropdown", "ivy", "select", "telescope", "vertical", "vscode"
      },
      formatters = {
        file = {
          filename_first = true,
        },
      },
      win = {
        input = {
          keys = {
            ["<Esc>"] = { "close", mode = { "n", "i" } },
            ["<c-c>"] = { "bufdelete", mode = { "i", "n" } },
            ["dd"] = false,
            ["<c-d>"] = { "preview_scroll_down", mode = { "i", "n" } },
            ["<c-u>"] = { "preview_scroll_up", mode = { "i", "n" } },
            ["<c-f>"] = false,
            ["<c-b>"] = false,
            ["<c-h>"] = { "toggle_help", mode = { "n", "i" } },
            ["?"] = false,
          },
        },
        list = {
          keys = {
            ["<c-c>"] = "bufdelete",
            ["dd"] = false,
            ["<c-d>"] = "preview_scroll_down",
            ["<c-u>"] = "preview_scroll_up",
            ["<c-f>"] = false,
            ["<c-b>"] = false,
          },
        },
      },
    },
  },
}
