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
      },
      {
        "<leader>\\",
        ":LazyDoPin bottomright<CR>",
      },
    },
    opts = {},
  },
}
