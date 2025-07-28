------------------------------------
-- FLAGS
------------------------------------
require("utils.flags").setup({
  icons = true,
  flags = {
    ai = { default = false, options = { "copilot", "openrouter", "openai", false } },
    copilot = { default = "opencode", options = { "opencode", "codecompanion" } },
    theme = { default = false, options = { "catppuccin", "vague", false } },
    debugger = false,
    suggestions = false,
    tests = false,
  },
})
