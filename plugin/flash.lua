vim.pack.add({ "https://github.com/folke/flash.nvim" }, { load = true, confirm = false })

require("flash").setup({
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
vim.keymap.set({"n", "x", "o"}, "s", function() require("flash").jump() end, { desc = "Flash" })
--stylua: ignore end
