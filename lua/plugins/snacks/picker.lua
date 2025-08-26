local M = {}

local git = require("utils.git")
local picker_utils = require("utils.snacks.picker")

M.config = {
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
          ["<c-c>"] = false,
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
          ["<c-c>"] = false,
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
      buffers = {
        win = {
          input = {
            keys = {
              ["<c-c>"] = { "bufdelete", mode = { "n", "i" } },
            },
          },
          list = { keys = { ["<c-c>"] = "bufdelete" } },
        },
      },
    },
  },
}

M.keymaps = {

  vim.keymap.set("n", "<leader>ff", function()
    if git.is_git_repo() then
      return Snacks.picker.git_files({ cwd = git.get_workspace_root() })
    end

    Snacks.picker.files({ cwd = git.get_workspace_root() })
  end, { desc = "Find Files" }),

  vim.keymap.set("n", "<leader>fg", function()
    Snacks.picker.grep({ cwd = git.get_workspace_root() })
  end, { desc = "Grep Files" }),

  vim.keymap.set("n", "<leader>fr", function()
    Snacks.picker.recent()
  end, { desc = "Recent Files" }),

  vim.keymap.set("n", "<leader>fs", function()
    Snacks.picker.smart()
  end, { desc = "Smart Files" }),

  vim.keymap.set("n", "<leader>fh", function()
    Snacks.picker.help()
  end, { desc = "Find Help" }),

  vim.keymap.set("n", "<leader>fb", function()
    Snacks.picker.grep_buffers()
  end, { desc = "Grep Buffers" }),

  vim.keymap.set("n", "<leader><leader>", function()
    Snacks.picker.buffers()
  end, { desc = "Buffers" }),

  vim.keymap.set("n", "<leader>cc", function()
    Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
  end, { desc = "Config Files" }),

  vim.keymap.set("n", "<leader>f<backspace>", function()
    Snacks.picker.resume()
  end, { desc = "Resume Picker" }),

  vim.keymap.set("n", "<leader>fP", function()
    Snacks.picker.pickers()
  end, { desc = "Pickers" }),

  vim.keymap.set("n", "<leader>fp", function()
    Snacks.picker.projects()
  end, { desc = "Projects" }),

  vim.keymap.set("n", "<leader>fl", function()
    Snacks.picker.lines()
  end, { desc = "Lines" }),

  vim.keymap.set("n", "<leader>R", function()
    Snacks.rename.rename_file()
  end, { desc = "Rename" }),

  vim.keymap.set("n", "-", function()
    require("utils.snacks.scratch").new_scratch()
  end, { desc = "New Scratch" }),

  vim.keymap.set("n", "_", function()
    require("utils.snacks.scratch").select_scratch()
  end, { desc = "Select Scratch" }),

  vim.keymap.set("n", "|", function()
    Snacks.picker.lsp_symbols()
  end, { desc = "Symbols" }),
}

return M
