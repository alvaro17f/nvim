------------------------------------
-- FLAGS
------------------------------------
require("utils.flags").setup({
  icons = true,
  flags = {
    ai = { default = false, options = { "copilot", "openrouter", "openai", false } },
    debugger = false,
    tests = false,
  },
})
