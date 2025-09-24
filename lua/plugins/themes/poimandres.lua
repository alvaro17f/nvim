Pack.add({ { src = "https://github.com/olivercederborg/poimandres.nvim", name = "poimandres" } })

local palette = require("poimandres.palette")
local poimandres = require("poimandres")

vim.o.winborder = "none"

poimandres.setup({
  bold_vert_split = false,
  dim_nc_background = false,
  disable_background = true,
  disable_float_background = true,
  disable_italics = false,

  highlight_groups = {
    FloatBorder = { bg = palette.none, fg = palette.text },
    LspReferenceRead = { link = "Visual" },
    LspReferenceText = { link = "Visual" },
    LspReferenceWrite = { link = "Visual" },
    NormalFloat = { bg = palette.none, fg = palette.text },
    WinBar = { bg = palette.none, fg = palette.text },
    WinSeparator = { fg = palette.background1 },
  },
})

vim.cmd.colorscheme("poimandres")
