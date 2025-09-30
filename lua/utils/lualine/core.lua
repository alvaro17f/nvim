_G.Utils = _G.Utils or {}
_G.Utils.lualine = _G.Utils.lualine or {}
_G.Utils.lualine.core = _G.Utils.lualine.core or {}

Utils.lualine.core = {
  branch = function()
    return {
      "branch",
      icon = Utils.icons.lualine.git.commit,
    }
  end,

  datetime = function()
    return {
      "datetime",
      style = Utils.icons.lualine.clock .. " %H:%M",
      separator = Utils.icons.lualine.separator.rounded,
      left_padding = 2,
    }
  end,

  diagnostics = function()
    return {
      "diagnostics",
      symbols = Utils.icons.diagnostics,
      separator = { right = "" },
    }
  end,

  diff = function()
    return {
      "diff",
      symbols = Utils.icons.diff,
    }
  end,

  encoding = function()
    return { "encoding" }
  end,

  filename = function()
    return {
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
      separator = { right = "" },
    }, {
      "filename",
      path = 0,
      file_status = false,
      color = function()
        return { fg = Utils.color("lualine_a_normal", "bg"), gui = vim.bo.modified and "italic,bold" or "bold" }
      end,
    }
  end,

  filetype = function()
    return { "filetype" }
  end,

  location = function()
    return { "location" }
  end,

  macro = function()
    return {
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
    }
  end,

  mode = function()
    return {
      "mode",
      icon = Utils.icons.lualine.logo.vim,
    }
  end,

  progress = function()
    return { "progress" }
  end,
}
