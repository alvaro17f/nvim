-- https://github.com/nvim-lualine/lualine.nvim/blob/master/THEMES.md
return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "echasnovski/mini.icons",
  },
  config = function()
    local lualine = require("lualine")
    local lazy_status = require("lazy.status") -- to configure lazy pending updates count

    lualine.setup({
      options = {
        theme = "horizon", -- "auto", "horizon", "catppuccin"
        globalstatus = true,
        disabled_filetypes = {
          statusline = {
            "alpha",
            "dashboard",
            "lazy",
            "lazygit",
            "mason",
            "minifiles",
            "starter",
            "TelescopePrompt",
            -- "toggleterm",
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
            require("noice").api.statusline.mode.get,
            cond = require("noice").api.statusline.mode.has,
            color = { fg = "#ff9e64" },
          }, --showmode
        },
        lualine_y = { "encoding" },
        lualine_z = { "progress", "location" },
      },
    })
  end,
}
