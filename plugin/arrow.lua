vim.pack.add({ "https://github.com/otavioschwanck/arrow.nvim" }, { load = true, confirm = false })

require("arrow").setup({
  show_icons = true,
  leader_key = ";", -- Recommended to be a single key
  buffer_leader_key = "m", -- Per Buffer Mappings
  global_bookmarks = false, -- if true, arrow will save files globally (ignores separate_by_branch)
  save_key = "git_root", -- git_root, git_bare, or cwd
  separate_by_branch = true,
})
