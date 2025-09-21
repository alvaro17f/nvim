------------------------------------
-- NVIM
------------------------------------
require("utils")

Utils.require({
  path = "core",
  load = {
    early = {
      "ui",
      "pack",
      "flags",
      "options",
    },
  },
})

Utils.require({
  path = "plugins",
  init_files_lookup = true,
  load = {
    early = {
      "themes",
      "treesitter",
    },
  },
})
