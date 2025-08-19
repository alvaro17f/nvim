------------------------------------
-- FLAGS
------------------------------------
local options_by_path = require("utils.flags").get_options_by_path

local explorers = options_by_path(vim.fn.stdpath("config") .. "/lua/plugins/explorer/", { false })
local logos = options_by_path(vim.fn.stdpath("config") .. "/assets/logos/")
local themes = options_by_path(vim.fn.stdpath("config") .. "/lua/plugins/themes/", { false })

require("utils.flags").setup({
  icons = true,
  flags = {
    ai = { default = false, options = { "opencode", "copilot", false } },
    debugger = false,
    explorer = { default = "yazi", options = explorers },
    logo = { default = "neovim", options = logos },
    suggestions = false,
    tests = false,
    theme = { default = "tokyonight", options = themes },
  },
})
