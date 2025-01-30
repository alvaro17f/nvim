return {
  "tzachar/highlight-undo.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("highlight-undo").setup({
      leader_key = ";", -- Recommended to be a single key
      buffer_leader_key = "m", -- Per Buffer Mappings
      show_icons = true,
      global_bookmarks = true,
      keymaps = {
        Paste = {
          disabled = true,
        },
      },
    })
  end,
}
