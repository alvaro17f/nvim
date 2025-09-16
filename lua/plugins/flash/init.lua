Pack.add({ "https://github.com/folke/flash.nvim" })

local flash = require("flash")

flash.setup({
  modes = {
    search = {
      enabled = false,
      mode = "fuzzy", -- "fuzzy" | "exact" | "search"
    },
  },
  jump = {
    autojump = false,
  },
  char = {
    enabled = true,
    autohide = true,
    jump_labels = true,
    jump = {
      autojump = true,
    },
  },
})

--stylua: ignore start
vim.keymap.set({"n", "x", "o"}, "s",  flash.jump , { desc = "Flash" })
--stylua: ignore end
