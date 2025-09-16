Pack.add({ "https://github.com/echasnovski/mini.files" })

local MiniFiles = require("mini.files")

MiniFiles.setup({
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
    permanent_delete = false,
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

local set_mark = function(id, path, desc)
  MiniFiles.set_bookmark(id, path, { desc = desc })
end

vim.api.nvim_create_autocmd("User", {
  pattern = { "MiniFilesExplorerOpen" },
  callback = function()
    set_mark("'", vim.fn.getcwd, "Working directory")
    set_mark("n", vim.fn.stdpath("config"), "Nvim config")
    set_mark("c", "~/.config", "Config directory")
    set_mark("d", "~/Downloads", "Downloads directory")
    set_mark("h", "~", "Home directory")
    set_mark("l", "~/.local", "Local directory")
    set_mark("w", "~/Workspace", "Workspace directory")
    set_mark("x", "~/Documents", "Documents directory")
  end,
})

vim.keymap.set("n", "<leader>/", "<CMD>lua MiniFiles.open()<CR>", { desc = "MiniFiles" })
