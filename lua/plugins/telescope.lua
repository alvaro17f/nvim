local telescope_utils = require("utils.telescope")

return {
  "nvim-telescope/telescope.nvim",
  lazy = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-telescope/telescope-frecency.nvim",
  },
  keys = {
    { mode = "n", "<leader>fr", ":Telescope frecency<CR>", desc = "Telescope recent files" },
    {
      mode = "n",
      "<leader>ff",
      telescope_utils.find_files,
      desc = "Telescope files",
    },
    {
      mode = "n",
      "<leader>fg",
      telescope_utils.live_grep,
      desc = "Telescope grep",
    },
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.load_extension("fzf")
    telescope.load_extension("frecency")

    telescope.setup({
      defaults = {
        path_display = { "filename_first" }, -- "smart", "filename_first"
        no_ignore = false,
        hidden = true,
        mappings = {
          i = {
            ["<esc>"] = actions.close,
            ["<c-j>"] = actions.move_selection_next,
            ["<c-k>"] = actions.move_selection_previous,
          },
        },
      },
      pickers = {
        buffers = {
          ignore_current_buffer = true,
          sort_lastused = true,
          sort_mru = true,
          mappings = {
            n = {
              ["<c-x>"] = actions.delete_buffer,
            },
            i = {
              ["<c-x>"] = actions.delete_buffer,
            },
          },
        },
        lsp_references = {
          include_current_line = false,
          show_line = false,
        },
      },
      extensions = {
        frecency = {
          auto_validate = false,
          default_workspace = "CWD",
          show_unindexed = false,
          ignore_patterns = { "*/.git", "*/.git/*", "*/.DS_Store", "*node_modules/*" },
        },
      },
    })
  end,
}
