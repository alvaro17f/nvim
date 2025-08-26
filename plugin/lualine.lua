vim.pack.add({ "https://github.com/nvim-lualine/lualine.nvim" }, { load = true, confirm = false })

vim.o.showmode = false

local lualine = require("lualine")

lualine.setup({
  options = {
    theme = "auto",
    component_separators = { left = "", right = "" }, -- 
    section_separators = { left = "", right = "" },
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
        symbols = {
          error = " ",
          warn = " ",
          hint = " ",
          info = " ",
        },
      },
      {
        "filename",
        path = 3,
      },
    },
    lualine_x = {
      {
        "diff",
        symbols = {
          added = " ",
          modified = " ",
          removed = " ",
        },
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
          return "  " .. os.date("%R")
        end,
        separator = { left = "", right = "" },
        left_padding = 2,
      },
    },
  },
})
