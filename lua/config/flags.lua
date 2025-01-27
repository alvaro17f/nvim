------------------------------------
-- FLAGS
------------------------------------
require("utils.flags").setup({
  icons = true,
  flags = {
    copilot = { default = false, options = { "copilot", "deepseek", false } },
    debugger = false,
    tests = false,
  },
})
