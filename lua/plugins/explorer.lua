if vim.fn.executable("yazi") == 1 then
  return {
    "mikavilpas/yazi.nvim",
    event = { "VeryLazy" },
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
      content = {
        filter = nil,
        prefix = nil,
        sort = nil,
      },

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
        permanent_delete = true,
        use_as_default_explorer = true,
      },

      windows = {
        max_number = math.huge,
        preview = true,
        width_focus = 50,
        width_nofocus = 15,
        width_preview = 50,
      },
    })
  end,
}
