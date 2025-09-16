Pack.add({ "https://github.com/folke/which-key.nvim" })

local which_key = require("which-key")

which_key.setup({
  preset = "helix",
  win = {
    title = true,
    title_pos = "left",
    col = math.huge,
    row = math.huge,
  },
})
