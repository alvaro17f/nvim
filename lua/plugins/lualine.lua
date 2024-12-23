-- https://github.com/nvim-lualine/lualine.nvim/blob/master/THEMES.md
return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "echasnovski/mini.icons" },
  config = function()
    local lualine = require("lualine")
    local lazy_status = require("lazy.status") -- to configure lazy pending updates count

    lualine.setup({
      options = {
        theme = "horizon", -- "auto", "horizon", "catppuccin"
        component_separators = "",
        section_separators = { left = "", right = "" },
        globalstatus = true,
        disabled_filetypes = {
          statusline = {
            "alpha",
            "dashboard",
            "fzf",
            "lazy",
            "lazygit",
            "mason",
            "minifiles",
            "oil",
            "snacks_dashboard",
            "starter",
            "TelescopePrompt",
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
          {
            require("nvim-possession").status,
            cond = function()
              return require("nvim-possession").status() ~= nil
            end,
          },
          "filetype",
          {
            require("noice").api.status.mode.get,
            cond = require("noice").api.status.mode.has,
            color = { fg = "#ff9e64" },
          }, --showmode
        },
        lualine_y = { "encoding" },
        lualine_z = { "progress", "location" },
      },
    })
  end,
}
