if require("utils.flags").get_flags("copilot") == false then
  return {}
end

return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  build = ":Copilot auth",
  lazy = false,
  opts = {
    suggestion = { enabled = false },
    panel = { enabled = false },
  },
}
