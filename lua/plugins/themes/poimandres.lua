Pack.add({ { src = "https://github.com/olivercederborg/poimandres.nvim", name = "poimandres" } })

local palette = require("poimandres.palette")
local poimandres = require("poimandres")

poimandres.setup({
  bold_vert_split = false,
  dim_nc_background = false,
  disable_background = true,
  disable_float_background = true,
  disable_italics = false,

  highlight_groups = {
    LspReferenceText = { link = "Visual" },
    LspReferenceRead = { link = "Visual" },
    LspReferenceWrite = { link = "Visual" },
    NormalFloat = { bg = palette.none, fg = palette.text },
    FloatBorder = { bg = palette.none, fg = palette.text },
  },
})

vim.cmd.colorscheme("poimandres")
