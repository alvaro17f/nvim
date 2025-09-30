_G.Utils = _G.Utils or {}
_G.Utils.lualine = _G.Utils.lualine or {}
_G.Utils.lualine.plugins = _G.Utils.lualine.plugins or {}

Utils.lualine.plugins = {
  arrow = function()
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
  end,

  sidekick = function()
    if Utils.require_safe("sidekick") then
      return {
        function()
          return Utils.icons.core.ai.copilot
        end,
        color = function()
          local status = require("sidekick.status").get()
          if status then
            return status.kind == "Error" and "DiagnosticError" or status.busy and "DiagnosticWarn" or "Special"
          end
        end,
        cond = function()
          local status = require("sidekick.status")
          return status.get() ~= nil
        end,
      }
    end

    return ""
  end,
}
