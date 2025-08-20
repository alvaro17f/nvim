-- https://github.com/nvim-lualine/lualine.nvim/blob/master/THEMES.md
return {
  "nvim-lualine/lualine.nvim",
  event = { "VeryLazy" },
  dependencies = { "echasnovski/mini.icons" },
  config = function()
    local lualine = require("lualine")
    local lazy_status = require("lazy.status") -- to configure lazy pending updates count

    lualine.setup({
      options = {
        theme = "auto", -- "auto", "horizon", "catppuccin"
        component_separators = "",
        section_separators = { left = "", right = "" },
        globalstatus = true,
        disabled_filetypes = {
          statusline = {
            "grug-far",
            "lazy",
            "lazydo",
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
        lualine_a = { "mode" },
        lualine_b = { "branch" },
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
          "filename",
        },
        lualine_x = {
          {
            lazy_status.updates,
            cond = lazy_status.has_updates,
            color = { fg = "#ff9e64" },
          },
          {
            "diff",
            symbols = {
              added = " ",
              modified = " ",
              removed = " ",
            },
          },
          "filetype",
          {
            "macro",
            fmt = function()
              local reg = vim.fn.reg_recording()
              if reg ~= "" then
                return "Recording @" .. reg
              end
              return nil
            end,
            color = { fg = "#ff9e64" },
            draw_empty = false,
          },
        },
        lualine_y = { "encoding" },
        lualine_z = { "progress", "location" },
      },
    })
  end,
}
