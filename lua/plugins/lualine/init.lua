Pack.add({ "https://github.com/nvim-lualine/lualine.nvim" })

vim.o.showmode = false

local lualine = require("lualine")

lualine.setup({
  options = {
    theme = vim.g.lualine or "auto",
    component_separators = Utils.icons.lualine.separator.component,
    section_separators = Utils.icons.lualine.separator.section,
    globalstatus = true,
    disabled_filetypes = {
      statusline = {
        "grug-far",
        "lazygit",
        "mason",
        "minifiles",
        "snacks_dashboard",
        "snacks_picker_input",
        "snacks_terminal",
        "yazi",
      },
    },
  },
  sections = {
    lualine_a = {
      Utils.lualine.core.mode(),
    },

    lualine_b = {
      Utils.lualine.core.branch(),
    },

    lualine_c = {
      Utils.lualine.core.diagnostics(),
      Utils.lualine.core.filename(),
    },

    lualine_x = {
      Utils.lualine.plugins.sidekick(),
      Utils.lualine.core.diff(),
      Utils.lualine.core.filetype(),
      Utils.lualine.core.encoding(),
      Utils.lualine.core.macro(),
    },

    lualine_y = {
      Utils.lualine.plugins.arrow(),
      Utils.lualine.core.progress(),
      Utils.lualine.core.location(),
    },

    lualine_z = {
      Utils.lualine.core.datetime(),
    },
  },
})
