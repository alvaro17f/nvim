Pack.add({ "https://github.com/nvim-lualine/lualine.nvim" })

vim.o.showmode = false

local lualine = require("lualine")
local color = require("utils").color
local icons = require("utils.icons")

local arrow = function()
  local require_safe = require("utils").require_safe

  if require_safe("arrow") then
    return {
      function()
        local statusline = require("arrow.statusline")
        return statusline.is_on_arrow_file() and statusline.text_for_statusline_with_icons() or ""
      end,
      color = function()
        return { fg = color("lualine_a_command", "bg"), gui = "bold" }
      end,
    }
  end

  return ""
end

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
      {
        "mode",
        icon = icons.lualine.logo.vim,
      },
    },
    lualine_b = {
      {
        "branch",
        icon = icons.lualine.git.commit,
      },
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
          local directory = vim.fn.trim(str:match("(.*/)(.*)"), "/", 2)
          return not directory:match("v:null") and directory or "<>"
        end,
        icon = {
          icons.core.arrows.double.right,
          align = "right",
          color = function()
            return { fg = color("lualine_a_replace", "bg") }
          end,
        },
        separator = "",
        padding = 1,
      },
      {
        "filename",
        path = 0,
        file_status = false,
        color = function()
          return { fg = color("lualine_a_normal", "bg"), gui = vim.bo.modified and "italic,bold" or "bold" }
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
            return icons.lualine.recording .. " recording: @" .. reg
          end
          return nil
        end,
        color = function()
          return { fg = color("lualine_a_replace", "bg"), gui = "bold" }
        end,
        draw_empty = false,
      },
    },
    lualine_y = {
      arrow(),
      { "progress" },
      { "location" },
    },
    lualine_z = {
      {
        "datetime",
        style = icons.lualine.clock .. " %H:%M",
        separator = icons.lualine.separator.rounded,
        left_padding = 2,
      },
    },
  },
})
