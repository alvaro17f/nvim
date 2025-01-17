if vim.fn.executable("yazi") == 1 then
  return {
    "mikavilpas/yazi.nvim",
    event = "VeryLazy",
    keys = {
      { mode = "n", "<leader>/", "<CMD>Yazi<CR>", silent = true, desc = "Open Yazi" },
    },
    opts = {
      open_for_directories = true, -- use yazi instead of netrw for directories
      open_multiple_tabs = true,
      keymaps = {
        show_help = "<f1>",
        open_file_in_vertical_split = "<c-v>",
        open_file_in_horizontal_split = "<c-s>",
        open_file_in_tab = false,
        grep_in_directory = false,
        replace_in_directory = "<c-r>",
        cycle_open_buffers = false,
        copy_relative_path_to_selected_files = "<c-y>",
        send_to_quickfix_list = "<c-q>",
        change_working_directory = ";",
      },
      future_features = {
        ya_emit_reveal = true,
        ya_emit_open = true,
      },
    },
  }
end

return {
  "echasnovski/mini.files",
  version = false,
  keys = {
    { mode = "n", "<Leader>/", "<CMD>lua MiniFiles.open()<CR>", silent = true, desc = "Open file manager" },
  },
  config = function()
    require("mini.files").setup({
      -- No need to copy this inside `setup()`. Will be used automatically.
      -- Customization of shown content
      content = {
        -- Predicate for which file system entries to show
        filter = nil,
        -- What prefix to show to the left of file system entry
        prefix = nil,
        -- In which order to show file system entries
        sort = nil,
      },

      -- Module mappings created only inside explorer.
      -- Use `''` (empty string) to not create one.
      mappings = {
        close = "q",
        go_in = "L",
        go_in_plus = "l",
        go_out = "H",
        go_out_plus = "h",
        mark_goto = "'",
        mark_set = "m",
        reset = "<BS>",
        reveal_cwd = "@",
        show_help = "g?",
        synchronize = "=",
        trim_left = ">",
        trim_right = "<",
      },

      -- General options
      options = {
        -- Whether to delete permanently or move into module-specific trash
        permanent_delete = true,
        -- Whether to use for editing directories
        use_as_default_explorer = true,
      },

      -- Customization of explorer windows
      windows = {
        -- Maximum number of windows to show side by side
        max_number = math.huge,
        -- Whether to show preview of file/directory under cursor
        preview = true,
        -- Width of focused window
        width_focus = 50,
        -- Width of non-focused window
        width_nofocus = 15,
        -- Width of preview window
        width_preview = 50,
      },
    })
  end,
}
