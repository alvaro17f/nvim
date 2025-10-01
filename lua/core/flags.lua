------------------------------------
-- FLAGS
------------------------------------
---@class Flags
---@field copilot boolean|string
---@field debugger boolean
---@field explorer string
---@field logo string
---@field mason boolean
---@field suggestions boolean|string
---@field tests boolean
---@field theme string
_G.Flags = _G.Flags or {}

local explorers = Utils.flags.get_options_by_path(vim.fn.stdpath("config") .. "/lua/plugins/explorers/", { false })
local logos = Utils.flags.get_options_by_path(vim.fn.stdpath("config") .. "/assets/logos/")
local themes = Utils.flags.get_options_by_path(vim.fn.stdpath("config") .. "/lua/plugins/themes/", { false })

local flags = {
  copilot = { default = false, options = { "sidekick", false } },
  debugger = false,
  explorer = { default = "yazi", options = explorers },
  logo = { default = "neovim", options = logos },
  mason = false,
  suggestions = { default = false, options = { "lsp", "neocodeium", false } },
  tests = false,
  theme = { default = "catppuccin", options = themes },
}

Utils.flags.setup({
  icons = true,
  flags = flags,
})

------------------------------------
-- GLOBAL FLAGS
------------------------------------
for flag_name, _ in pairs(flags) do
  Flags[flag_name] = Utils.flags.get_flags(flag_name) or false
end
