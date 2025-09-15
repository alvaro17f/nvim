Pack.add({ "https://github.com/nvim-lualine/lualine.nvim" })

vim.o.showmode = false

local lualine = require("lualine")

local arrow = function()
  if Utils.require_safe("arrow") then
    return {
      function()
        local statusline = require("arrow.statusline")
        return statusline.is_on_arrow_file() and statusline.text_for_statusline_with_icons() or ""
      end,
      color = function()
        return { fg = Utils.color("lualine_a_command", "bg"), gui = "bold" }
      end,
    }
  end

  return ""
end

lualine.setup({
  options = {
    theme = "auto",
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
      {
        "mode",
        icon = Utils.icons.lualine.logo.vim,
      },
    },
    lualine_b = {
      {
        "branch",
        icon = Utils.icons.lualine.git.commit,
      },
    },
    lualine_c = {
      {
        "diagnostics",
        symbols = Utils.icons.diagnostics,
      },
      {
        "filename",
        path = 3,
        file_status = false,
        fmt = function(str)
          local directory = str:match("(.*)/.*$")
          local is_directory = directory and not directory:match("v:null")
          return is_directory and directory or "<>"
        end,
        icon = {
          Utils.icons.core.arrows.double.right,
          align = "right",
          color = function()
            return { fg = Utils.color("lualine_a_replace", "bg") }
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
          return { fg = Utils.color("lualine_a_normal", "bg"), gui = vim.bo.modified and "italic,bold" or "bold" }
        end,
        padding = { left = 0, right = 1 },
      },
    },
    lualine_x = {
      {
        "diff",
        symbols = Utils.icons.diff,
      },
      { "filetype" },
      { "encoding" },
      {
        "macro",
        fmt = function()
          local reg = vim.fn.reg_recording()
          if reg ~= "" then
            return Utils.icons.lualine.recording .. " recording: @" .. reg
          end
          return nil
        end,
        color = function()
          return { fg = Utils.color("lualine_a_replace", "bg"), gui = "bold" }
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
        style = Utils.icons.lualine.clock .. " %H:%M",
        separator = Utils.icons.lualine.separator.rounded,
        left_padding = 2,
      },
    },
  },
})
