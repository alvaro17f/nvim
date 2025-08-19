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
