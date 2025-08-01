------------------------------------
-- FLAGS
------------------------------------
require("utils.flags").setup({
  icons = true,
  flags = {
    ai = { default = false, options = { "opencode", "copilot", false } },
    debugger = false,
    suggestions = false,
    tests = false,
    theme = { default = "catppuccin", options = { "catppuccin", "vague", false } },
  },
})
