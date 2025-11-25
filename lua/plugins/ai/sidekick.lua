Pack.add({ "https://github.com/folke/sidekick.nvim" })

---@type "crush" | "opencode"
local tool = "opencode"

local sidekick = require("sidekick")
local sidekick_cli = require("sidekick.cli")

sidekick.setup({
  cli = {
    tools = {
      crush = {
        cmd = { "crush" },
        url = "https://github.com/charmbracelet/crush",
        keys = {
          prompt = { "<a-'>", "prompt" },
        },
      },
      opencode = {
        cmd = { "opencode" },
        url = "https://github.com/sst/opencode",
      },
    },
    win = {
      bo = {
        filetype = "copilot",
      },
      keys = {
        prompt = { "<a-'>", "prompt" },
      },
    },
  },
})

vim.keymap.set({ "i", "n" }, "<tab>", function()
  if sidekick.nes_jump_or_apply() then
    return
  end

  if vim.lsp.inline_completion.get() then
    return
  end

  return "<tab>"
end, {
  expr = true,
  desc = "Goto/Apply Next Edit Suggestion",
})

vim.keymap.set({ "n", "i", "t" }, "<c-'>", function()
  sidekick_cli.toggle({ name = tool, focus = true })
end, { desc = "Sidekick: Toggle CLI" })

vim.keymap.set({ "x" }, "<c-'>", function()
  sidekick_cli.send({ msg = "{selection}", name = tool, focus = true })
end, { desc = "Sidekick: Send Visual Selection" })

vim.keymap.set({ "n", "v" }, "<a-'>", function()
  sidekick_cli.prompt()
end, { desc = "Sidekick: Ask Prompt" })
