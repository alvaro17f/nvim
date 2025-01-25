local git = require("utils.git")
local picker_utils = require("utils.snacks.picker")

return {
  "snacks.nvim",
  keys = {
    {
      "<leader>ff",
      function()
        if git.is_git_repo() then
          return Snacks.picker.git_files({ cwd = git.get_workspace_root() })
        end

        Snacks.picker.files({ cwd = git.get_workspace_root() })
      end,
      desc = "Find files",
    },
    {
      "<leader>fg",
      function()
        Snacks.picker.grep({ cwd = git.get_workspace_root() })
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
            ["<c-d>"] = "preview_scroll_down",
            ["<c-u>"] = "preview_scroll_up",
            ["<c-f>"] = false,
            ["<c-b>"] = false,
          },
        },
      },
      sources = {
        files = {
          actions = {
            switch_grep_files = function(picker, _)
              picker_utils.status = {
                is_grep = false,
                is_git = false,
              }
              picker_utils.switch_grep_files(picker, _)
            end,
          },
          win = {
            input = {
              keys = {
                ["<c-\\>"] = { "switch_grep_files", desc = "Switch to grep", mode = { "i", "v" } },
              },
            },
          },
        },
        git_files = {
          actions = {
            switch_grep_files = function(picker, _)
              picker_utils.status = {
                is_grep = false,
                is_git = true,
              }
              picker_utils.switch_grep_files(picker, _)
            end,
          },
          win = {
            input = {
              keys = {
                ["<c-\\>"] = { "switch_grep_files", desc = "Switch to grep", mode = { "i", "v" } },
              },
            },
          },
        },
        grep = {
          actions = {
            switch_grep_files = function(picker, _)
              picker_utils.status = {
                is_grep = true,
                is_git = git.is_git_repo(),
              }
              picker_utils.switch_grep_files(picker, _)
            end,
          },
          win = {
            input = {
              keys = {
                ["<c-\\>"] = { "switch_grep_files", desc = "Switch to files", mode = { "i", "v" } },
              },
            },
          },
        },
      },
    },
  },
}
