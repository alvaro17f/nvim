------------------------------------
-- FLAGS
------------------------------------
require("utils.flags").setup({
  icons = true,
  flags = {
    copilot = { default = false, options = { "copilot", "openrouter", "openai", false } },
    debugger = false,
    tests = false,
  },
})
