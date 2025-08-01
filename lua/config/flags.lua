------------------------------------
-- FLAGS
------------------------------------
local logos = require("utils.ui").get_logos()

require("utils.flags").setup({
  icons = true,
  flags = {
    ai = { default = false, options = { "opencode", "copilot", false } },
    debugger = false,
    logo = { default = logos[1], options = logos },
    suggestions = false,
    tests = false,
    theme = { default = "catppuccin", options = { "catppuccin", "vague", "dracula", false } },
  },
})
