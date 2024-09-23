return {
  "stevearc/oil.nvim",
  keys = {
    { mode = "n", "<leader>/", ":Oil --float<CR>", desc = "File explorer" },
  },
  dependencies = {
    "echasnovski/mini.icons",
  },
  opts = {
    default_file_explorer = true,
    delete_to_trash = true,
    skip_confirm_for_simple_edits = true,
    view_options = {
      show_hidden = true,
      natural_order = true,
      is_always_hidden = function(name, _)
        return name == ".." or name == ".git"
      end,
    },
    float = {
      padding = 2,
      max_width = 90,
      max_height = 0,
    },
    win_options = {
      wrap = true,
      winblend = 0,
    },
    use_default_keymaps = false,
    keymaps = {
      ["g?"] = "actions.show_help",
      ["q"] = "actions.close",
      ["h"] = "actions.parent",
      ["l"] = "actions.select",
      ["<BS>"] = "actions.open_cwd",
      ["<localleader>p"] = "actions.preview",
      ["<localleader>."] = "actions.toggle_hidden",
      ["<localleader>r"] = "actions.refresh",
      ["<localleader>,"] = "actions.change_sort",
      ["<localleader>\\"] = "actions.toggle_trash",
      ["gh"] = { "actions.cd", opts = { scope = "tab" }, desc = ":tcd to the current oil directory" },
      ["<c-w>v"] = {
        "actions.select",
        opts = { vertical = true },
        desc = "Open the entry in a vertical split",
      },
      ["<c-w>s"] = {
        "actions.select",
        opts = { horizontal = true },
        desc = "Open the entry in a horizontal split",
      },
    },
  },
}
