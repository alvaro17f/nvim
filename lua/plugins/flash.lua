return {
  "folke/flash.nvim",
  event = { "VeryLazy" },
  opts = {
    modes = {
      search = {
        enabled = true,
        mode = "fuzzy", -- "fuzzy" | "exact" | "search"
      },
    },
    jump = {
      autojump = false,
    },
  },
  --stylua: ignore
  keys = {
    { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
  },
}
