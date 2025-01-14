---@diagnostic disable: undefined-global, undefined-field
local M = {}

local fzf = require("fzf-lua")
local utils = require("fzf-lua.utils")

function M.scratch_buffers()
  local entries = {}
  local items = Snacks.scratch.list()
  local item_map = {}

  local function hl_validate(hl)
    return not utils.is_hl_cleared(hl) and hl or nil
  end

  local function ansi_from_hl(hl, s)
    return utils.ansi_from_hl(hl_validate(hl), s)
  end

  for _, item in ipairs(items) do
    item.icon = item.icon or Snacks.util.icon(item.ft, "filetype")
    item.branch = item.branch and ("branch:%s"):format(item.branch) or ""
    item.cwd = item.cwd and vim.fn.fnamemodify(item.cwd, ":p:~") or ""
    local display = string.format("%s %s %s %s", item.cwd, item.icon, item.name, item.branch) -- same as what Snacks.scratch uses to display items
    table.insert(entries, display)
    item_map[display] = item
  end

  fzf.fzf_exec(entries, {
    prompt = "Scratch Buffers: ",
    fzf_opts = {
      ["--header"] = string.format(
        ":: <%s> to %s | <%s> to %s",
        ansi_from_hl("FzfLuaHeaderBind", "enter"),
        ansi_from_hl("FzfLuaHeaderText", "Select Scratch"),
        ansi_from_hl("FzfLuaHeaderBind", "ctrl-x"),
        ansi_from_hl("FzfLuaHeaderText", "Delete Scratch")
      ),
    },
    actions = {
      ["default"] = function(selected)
        local item = item_map[selected[1]]
        Snacks.scratch.open({ icon = item.icon, file = item.file, name = item.name, ft = item.ft })
      end,
      ["ctrl-x"] = {
        function(selected)
          local item = item_map[selected[1]]
          os.remove(item.file)
          vim.notify("Deleted scratch file: " .. item.file)
          M.scratch_buffers()
        end,
      },
    },
  })
end

return M
