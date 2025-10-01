Pack.add({ "https://github.com/folke/sidekick.nvim" })

---@type "crush" | "opencode"
local tool = "opencode"

local sidekick = require("sidekick")
local sidekick_cli = require("sidekick.cli")

sidekick.setup({
  cli = {
    tools = {
      crush = {
        cmd = { "crush", "-D", vim.env.HOME .. "/.cache/crush" },
        url = "https://github.com/charmbracelet/crush",
        keys = {
          prompt = { "<c-a>", "prompt" },
        },
      },
      opencode = {
        cmd = { "opencode" },
        env = { OPENCODE_THEME = "system" },
        url = "https://github.com/sst/opencode",
      },
    },
    win = {
      bo = {
        filetype = "ai_chat",
      },
      keys = {
        prompt = { "<c-a>", "prompt" },
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

vim.keymap.set({ "n", "x", "i", "t" }, "<c-'>", function()
  sidekick_cli.toggle({ name = tool, focus = true })
end, { desc = "Sidekick: Toggle CLI" })

vim.keymap.set({ "n", "x", "i", "t" }, "<c-s-'>", function()
  sidekick_cli.focus({ name = tool })
end, { desc = "Sidekick: Focus CLI" })

vim.keymap.set({ "n", "v" }, "<c-a>", function()
  sidekick_cli.prompt()
end, { desc = "Sidekick: Ask Prompt" })
