------------------------------------
-- FLAGS
------------------------------------
local options_by_path = require("utils.flags").get_options_by_path

local explorers = options_by_path(vim.fn.stdpath("config") .. "/lua/plugins/explorers/", { false })
local logos = options_by_path(vim.fn.stdpath("config") .. "/assets/logos/")
local themes = options_by_path(vim.fn.stdpath("config") .. "/lua/plugins/themes/", { false })

require("utils.flags").setup({
  icons = true,
  flags = {
    ai = { default = false, options = { "opencode", "copilot", false } },
    debugger = false,
    explorer = { default = "yazi", options = explorers },
    logo = { default = "neovim", options = logos },
    mason = false,
    suggestions = false,
    tests = false,
    theme = { default = "tokyonight", options = themes },
  },
})

------------------------------------
-- GLOBAL FLAGS
------------------------------------
vim.g.ai = require("utils.flags").get_flags("ai") or false
vim.g.debugger = require("utils.flags").get_flags("debugger") or false
vim.g.explorer = require("utils.flags").get_flags("explorer") or false
vim.g.logo = require("utils.flags").get_flags("logo") or "neovim"
vim.g.mason = require("utils.flags").get_flags("mason") or false
vim.g.suggestions = require("utils.flags").get_flags("suggestions") or false
vim.g.tests = require("utils.flags").get_flags("tests") or false
vim.g.theme = require("utils.flags").get_flags("theme") or false
