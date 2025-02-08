return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  build = ":Copilot auth",
  lazy = false,
  config = function()
    local copilot = require("copilot")
    local suggestion = require("copilot.suggestion")

    copilot.setup({
      suggestion = {
        enabled = vim.g.suggestions,
        auto_trigger = true,
        hide_during_completion = true,
        debounce = 75,
        keymap = {
          accept = false,
          accept_word = false,
          accept_line = false,
          next = false,
          prev = false,
          dismiss = false,
        },
      },
      panel = { enabled = false },

      vim.keymap.set("i", "<Tab>", function()
        if suggestion.is_visible() then
          suggestion.accept()
        else
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", false)
        end
      end, { desc = "Copilot accept suggestion" }),

      vim.keymap.set("i", "<s-tab>", function()
        if suggestion.is_visible() then
          suggestion.next()
        else
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", false)
        end
      end, { desc = "Copilot next suggestion" }),
    })
  end,
}
