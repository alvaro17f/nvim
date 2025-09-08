vim.pack.add({ { src = "https://github.com/everviolet/nvim", name = "evergarden" } }, { load = true, confirm = false })

require("evergarden").setup({
  theme = {
    variant = "fall", -- 'winter'|'fall'|'spring'|'summer'
    accent = "green",
  },
  editor = {
    transparent_background = false,
    sign = { color = "none" },
    float = {
      color = "mantle",
      solid_border = false,
    },
  },
})

vim.cmd.colorscheme("evergarden")
