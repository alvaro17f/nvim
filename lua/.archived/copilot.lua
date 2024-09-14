return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  lazy = false,
  build = ":Copilot auth",
  opts = {
    suggestion = {
      enabled = true,
      auto_trigger = true,
    },
    panel = {
      enabled = true,
      auto_refresh = false,
    },
  },
}
