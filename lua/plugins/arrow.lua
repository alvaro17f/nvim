return {
  "otavioschwanck/arrow.nvim",
  opts = {
    show_icons = true,
    leader_key = ";", -- Recommended to be a single key
    buffer_leader_key = "m", -- Per Buffer Mappings

    function()
      require("arrow.git").refresh_git_branch() -- only if separated_by_branch is true
      require("arrow.persist").load_cache_file()
    end,
  },
}
