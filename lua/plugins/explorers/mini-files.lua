vim.pack.add({ "https://github.com/echasnovski/mini.files" }, { load = true, confirm = false })

vim.keymap.set("n", "<leader>/", "<CMD>lua MiniFiles.open()<CR>", { desc = "MiniFiles" })
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
