Pack.add({ { src = "https://github.com/Everblush/nvim", name = "everblush" } })

local everblush = require("everblush")

everblush.setup({
  transparent_background = false,
  override = {
    BlinkCmpDocBorder = { fg = "Comment" },
    BlinkCmpMenuBorder = { fg = "Comment" },
    FloatBorder = { fg = "Comment" },
    NormalFloat = { bg = "none" },
    StatusLine = { bg = "none" },
    WinBar = { bg = "none", fg = "Text" },
    WinSeparator = { fg = "Comment" },
  },
})

vim.cmd.colorscheme("everblush")
