Pack.add({
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/mikavilpas/yazi.nvim",
})

local yazi = require("yazi")

yazi.setup({
  open_for_directories = true, -- use yazi instead of netrw for directories
  open_multiple_tabs = false,
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
    use_cwd_file = true,
    new_shell_escaping = true,
  },
})

vim.keymap.set("n", "<leader>/", "<CMD>Yazi cwd<CR>", { desc = "Yazi" })
