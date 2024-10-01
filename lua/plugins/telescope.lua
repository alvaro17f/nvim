return {
  {
    "nvim-telescope/telescope.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    keys = {
      { mode = "n", "<leader>fr", ":Telescope oldfiles<CR>", desc = "Telescope recent files" },
      {
        mode = "n",
        "<leader>ff",
        function()
          local opts = {}
          if require("utils.git").is_git_repo() then
            opts = {
              cwd = require("utils.git").get_git_root(),
            }
          end
          require("telescope.builtin").find_files(opts)
        end,
        desc = "Telescope files",
      },
      {
        mode = "n",
        "<leader>fg",
        function()
          local opts = {}
          if require("utils.git").is_git_repo() then
            opts = {
              cwd = require("utils.git").get_git_root(),
            }
          end
          require("telescope.builtin").live_grep(opts)
        end,
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
      })
    end,
  },
  {
    "axkirillov/hbac.nvim",
    lazy = false,
    keys = {
      { mode = "n", "<leader>b", ":Telescope hbac buffers<CR>", desc = "Telescope buffers" },
    },
    config = function()
      local actions = require("hbac.telescope.actions")
      require("hbac").setup({
        autoclose = true, -- set autoclose to false if you want to close manually
        threshold = 10, -- hbac will start closing unedited buffers once that number is reached
        close_command = function(bufnr)
          vim.api.nvim_buf_delete(bufnr, {})
        end,
        close_buffers_with_windows = false, -- hbac will close buffers with associated windows if this option is `true`
        telescope = {
          ignore_current_buffer = false,
          selection_strategy = "row",
          sort_lastused = true,
          sort_mru = true,
          use_default_mappings = true, -- false to not include the mappings below
          mappings = {
            i = {
              ["<c-x>"] = actions.delete_buffer,
              ["<c-p>"] = actions.toggle_pin,
            },
          },
        },
      })
    end,
  },
}
