------------------------------------
-- NVIM
------------------------------------
require("utils")

Utils.require_inits("core", {
  early = {
    "ui",
    "pack",
    "flags",
    "options",
  },
})

Utils.require_inits("plugins", {
  early = {
    "themes",
    "treesitter",
  },
})
