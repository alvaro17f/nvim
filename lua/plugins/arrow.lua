return {
  "otavioschwanck/arrow.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("arrow").setup({
      leader_key = ";", -- Recommended to be a single key
      buffer_leader_key = "m", -- Per Buffer Mappings
      show_icons = true,
      global_bookmarks = true,
    })

    require("arrow.git").refresh_git_branch() -- only if separated_by_branch is true
    require("arrow.persist").load_cache_file()
  end,
}
