------------------------------------
-- FLAGS
------------------------------------
local logos = require("utils.ui").get_logos()

require("utils.flags").setup({
  icons = true,
  flags = {
    ai = { default = false, options = { "opencode", "copilot", false } },
    debugger = false,
    logo = { default = logos.neovim, options = logos },
    suggestions = false,
    tests = false,
    theme = { default = "catppuccin", options = { "catppuccin", "vague", false } },
  },
})
