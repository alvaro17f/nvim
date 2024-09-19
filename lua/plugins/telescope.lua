local telescope_utils = require("utils.telescope")

return {
  "nvim-telescope/telescope.nvim",
  lazy = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  keys = {
    { mode = "n", "<leader>b", ":Telescope buffers<CR>", desc = "Telescope buffers" },
    { mode = "n", "<leader>fr", ":Telescope oldfiles<CR>", desc = "Telescope recent files" },
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

    telescope.setup({

      defaults = {
        path_display = { "filename_first" }, -- "smart", "filename_first"
        mappings = {
          n = {
            ["<c-x>"] = actions.delete_buffer,
          },
          i = {
            ["<esc>"] = actions.close,
            ["<c-j>"] = actions.move_selection_next,
            ["<c-k>"] = actions.move_selection_previous,
            ["<c-x>"] = actions.delete_buffer,
          },
        },
      },
      pickers = {
        buffers = {
          ignore_current_buffer = true,
          sort_lastused = true,
          sort_mru = true,
        },
        find_files = {
          no_ignore = false,
          hidden = true,
        },
        git_files = {
          no_ignore = false,
          hidden = true,
        },
        live_grep = {
          no_ignore = false,
          hidden = true,
        },
        lsp_references = {
          include_current_line = true,
          show_line = false,
        },
      },
    })
  end,
}
