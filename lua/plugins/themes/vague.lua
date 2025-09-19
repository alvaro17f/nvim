Pack.add({ { src = "https://github.com/vague2k/vague.nvim", name = "vague" } })

vim.o.winborder = ""

local vague = require("vague")

vague.setup({
  transparent = false,

  on_highlights = function(hl, c)
    hl.WinBar = {
      bg = c.bg,
      fg = c.fg,
    }
  end,
})

vim.cmd.colorscheme("vague")
