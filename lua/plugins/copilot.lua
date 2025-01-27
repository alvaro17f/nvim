if vim.g.copilot == false then
  return {}
end

local provider = vim.g.copilot

local code_companion_cmd = function()
  local user_input = vim.fn.input("CodeCompanionCmd: ")
  vim.cmd("CodeCompanionCmd " .. user_input)
end

return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    lazy = false,
    config = function()
      local copilot = require("copilot")
      local suggestion = require("copilot.suggestion")

      copilot.setup({
        suggestion = {
          enabled = true,
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
  },
  {
    "olimorris/codecompanion.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    keys = {
      { mode = "n", "<leader>a", "<CMD>CodeCompanionChat Toggle<CR>", silent = true, desc = "CodeCompanion toggle" },
      { mode = "v", "<leader>a", "<CMD>CodeCompanionActions<CR>", silent = true, desc = "CodeCompanion actions" },
      { mode = "n", "<leader>:", code_companion_cmd, desc = "CodeCompanionCmd" },
      { mode = "v", "ga", "<CMD>CodeCompanionChat Add<CR>", silent = true, desc = "CodeCompanion add" },
      {
        mode = "n",
        "<leader>gc",
        "<CMD>CodeCompanion /commit<CR>",
        silent = true,
        desc = "CodeCompanion generate commit",
      },
    },
    config = function()
      require("codecompanion").setup({
        strategies = {
          chat = {
            adapter = provider,
          },
          inline = {
            adapter = provider,
          },
          agent = {
            adapter = provider,
          },
        },
        adapters = {
          openai = function()
            return require("codecompanion.adapters").extend("openai", {
              env = {
                api_key = "OPENAI_API_KEY",
              },
            })
          end,
        },
      })
    end,
  },
}
