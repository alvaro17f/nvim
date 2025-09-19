Pack.add({ { src = "https://github.com/everviolet/nvim", name = "evergarden" } })

vim.o.winborder = ""

local evergarden = require("evergarden")

evergarden.setup({
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
