------------------------------------
-- FLAGS
------------------------------------
local options_by_path = require("utils.flags").get_options_by_path

local logos = options_by_path(vim.fn.stdpath("config") .. "/assets/dashboard/")
local themes = options_by_path(vim.fn.stdpath("config") .. "/lua/plugins/themes/", { false })

require("utils.flags").setup({
  icons = true,
  flags = {
    ai = { default = false, options = { "opencode", "copilot", false } },
    debugger = false,
    logo = { default = logos[1], options = logos },
    suggestions = false,
    tests = false,
    theme = { default = themes[1], options = themes },
  },
})
