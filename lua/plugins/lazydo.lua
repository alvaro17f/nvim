return {
  {
    "Dan7h3x/LazyDo",
    branch = "main",
    event = "VeryLazy",
    cmd = { "LazyDoToggle", "LazyDoPin" },
    keys = {
      {
        "\\",
        ":LazyDoToggle<CR>",
        desc = "Toggle LazyDo",
      },
      {
        "<leader>\\",
        ":LazyDoPin bottomright<CR>",
        desc = "Pin LazyDo",
      },
    },
    opts = {
      pin_window = {
        enabled = false, --TODO: this helps to keep position at bottom right
        position = "bottomright", -- "topright", "topleft", "bottomright", "bottomleft"
      },
    },
  },
}
