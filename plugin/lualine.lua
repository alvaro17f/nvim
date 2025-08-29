vim.pack.add({ "https://github.com/nvim-lualine/lualine.nvim" }, { load = true, confirm = false })

vim.o.showmode = false

local icons = require("utils.icons")
local lualine = require("lualine")

lualine.setup({
  options = {
    theme = "auto",
    component_separators = icons.lualine.separator.component,
    section_separators = icons.lualine.separator.section,
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
      "mode",
    },
    lualine_b = {
      "branch",
    },
    lualine_c = {
      {
        "diagnostics",
        symbols = icons.diagnostics,
      },
      {
        "filename",
        path = 3,
        file_status = false,
        fmt = function(str)
          local directory = str:match("(.*/)(.*)")
          return directory or " "
        end,
        separator = { right = "" },
        padding = { left = 1, right = 0 },
      },
      {
        "filename",
        path = 0,
        file_status = false,
        color = function()
          return { fg = "cyan", gui = vim.bo.modified and "italic,bold" or "bold" }
        end,
        padding = { left = 0, right = 1 },
      },
    },
    lualine_x = {
      {
        "diff",
        symbols = icons.diff,
      },
      { "filetype" },
      { "encoding" },
      {
        "macro",
        fmt = function()
          local reg = vim.fn.reg_recording()
          if reg ~= "" then
            return "recording @" .. reg
          end
          return nil
        end,
        color = { fg = "#ff9e64" },
        draw_empty = false,
      },
    },
    lualine_y = {
      { "progress" },
      { "location" },
    },
    lualine_z = {
      {
        function()
          return icons.lualine.clock .. os.date("%R")
        end,
        separator = icons.lualine.separator.rounded,
        left_padding = 2,
      },
    },
  },
})
