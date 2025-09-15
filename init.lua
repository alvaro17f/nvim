------------------------------------
-- NVIM
------------------------------------
require("core.ui")
require("core.pack")
require("core.flags")
require("core.options")
require("core.keymaps")
require("core.autocmds")

require("utils").require_inits("plugins", {
  "themes",
  "treesitter",
})
