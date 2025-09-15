------------------------------------
-- NVIM
------------------------------------
require("utils")
require("core.ui")
require("core.pack")
require("core.flags")
require("core.options")
require("core.keymaps")
require("core.autocmds")

Utils.require_inits("plugins", {
  "themes",
  "treesitter",
})
