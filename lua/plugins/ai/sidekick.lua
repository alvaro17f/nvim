Pack.add({ "https://github.com/folke/sidekick.nvim" })

local sidekick = require("sidekick")
local sidekick_cli = require("sidekick.cli")

sidekick.setup({
  cli = {
    win = {
      bo = {
        filetype = "opencode_terminal",
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

vim.keymap.set({ "n", "v", "t" }, "<c-'>", function()
  sidekick_cli.toggle({ name = "opencode", focus = true })
end, { desc = "Sidekick Toggle CLI" })

vim.keymap.set({ "n", "v" }, "<leader>aa", function()
  sidekick_cli.select_prompt()
end, { desc = "Sidekick Ask Prompt" })
