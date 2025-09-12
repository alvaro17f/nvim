Pack.add({ "https://github.com/otavioschwanck/arrow.nvim" })

local global_bookmarks = true

require("arrow").setup({
  show_icons = true,
  leader_key = ";",
  buffer_leader_key = "m",
  global_bookmarks = global_bookmarks,
  save_key = global_bookmarks and "cwd" or "git_root",
  separate_by_branch = true,
})
