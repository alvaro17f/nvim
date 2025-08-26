vim.pack.add(
  { { src = "https://github.com/olivercederborg/poimandres.nvim", name = "poimandres" } },
  { load = true, confirm = false }
)

local p = require("poimandres.palette")

require("poimandres").setup({
  bold_vert_split = false,
  dim_nc_background = false,
  disable_background = true,
  disable_float_background = true,
  disable_italics = false,

  highlight_groups = {
    LspReferenceText = { link = "Visual" },
    LspReferenceRead = { link = "Visual" },
    LspReferenceWrite = { link = "Visual" },
    NormalFloat = { bg = p.none, fg = p.text },
    FloatBorder = { bg = p.none, fg = p.text },
  },
})

vim.cmd.colorscheme("poimandres")
