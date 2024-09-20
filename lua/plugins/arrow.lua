return {
  "otavioschwanck/arrow.nvim",
  config = function()
    require("arrow").setup({
      leader_key = ";", -- Recommended to be a single key
      buffer_leader_key = "m", -- Per Buffer Mappings
      show_icons = true,
      separate_by_branch = true, -- Bookmarks will be separated by git branch
      global_bookmarks = true,
    })

    require("arrow.git").refresh_git_branch() -- only if separated_by_branch is true
    require("arrow.persist").load_cache_file()
  end,
}
