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
      desc = "Picker: find files",
    },
    {
      "<leader>fg",
      function()
        Snacks.picker.grep({ cwd = git.get_workspace_root() })
      end,
      desc = "Picker: grep",
    },
    {
      "<leader>fr",
      function()
        Snacks.picker.recent()
      end,
      desc = "Picker: recent",
    },
    {
      "<leader>fs",
      function()
        Snacks.picker.smart()
      end,
      desc = "Picker: Smart",
    },
    {
      "<leader>fh",
      function()
        Snacks.picker.help()
      end,
      desc = "Picker: help",
    },
    {
      "<leader>fb",
      function()
        Snacks.picker.grep_buffers()
      end,
      desc = "Picker: grep buffers",
    },
    {

      "<leader><leader>",
      function()
        Snacks.picker.buffers()
      end,
      desc = "Picker: buffers",
    },
    {
      "<leader>cc",
      function()
        Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
      end,
      desc = "Picker: nvim config",
    },
    {
      "<leader>f<backspace>",
      function()
        Snacks.picker.resume()
      end,
      desc = "Picker: resume",
    },
    {
      "<leader>fP",
      function()
        Snacks.picker.pickers()
      end,
      desc = "Picker: pickers",
    },
    {
      "<leader>fp",
      function()
        Snacks.picker.projects()
      end,
      desc = "Picker: projects",
    },
    {
      "<leader>fl",
      function()
        Snacks.picker.lines()
      end,
      desc = "Picker: lines",
    },
  },
  opts = {
    picker = {
      layout = {
        -- preset => "default", "dropdown", "ivy", "select", "telescope", "vertical", "vscode"
        preset = function()
          return vim.o.columns >= 120 and "default" or "vertical"
        end,
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
