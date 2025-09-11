------------------------------------
-- FLAGS
------------------------------------
_G.Flags = {}

local flags_utils = require("utils.flags")

local explorers = flags_utils.get_options_by_path(vim.fn.stdpath("config") .. "/lua/plugins/explorers/", { false })
local logos = flags_utils.get_options_by_path(vim.fn.stdpath("config") .. "/assets/logos/")
local themes = flags_utils.get_options_by_path(vim.fn.stdpath("config") .. "/lua/plugins/themes/", { false })

local flags = {
  ai = { default = false, options = { "opencode", "copilot", false } },
  debugger = false,
  explorer = { default = "yazi", options = explorers },
  logo = { default = "neovim", options = logos },
  mason = false,
  suggestions = false,
  tests = false,
  theme = { default = "catppuccin", options = themes },
}

flags_utils.setup({
  icons = true,
  flags = flags,
})

------------------------------------
-- GLOBAL FLAGS
------------------------------------
for flag_name, _ in pairs(flags) do
  Flags[flag_name] = flags_utils.get_flags(flag_name) or false
end
