if require("utils.flags").get_flags("copilot") == false then
  return {}
end

local provider = "copilot"

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
      "nvim-telescope/telescope.nvim", -- Optional: For using slash commands
      { "stevearc/dressing.nvim", opts = {} }, -- Optional: Improves the default Neovim UI
    },
    keys = {
      { mode = "n", "<leader>a", ":CodeCompanionChat Toggle<CR>", silent = true, desc = "CodeCompanion toggle" },
      { mode = "v", "<leader>a", ":CodeCompanionActions<CR>", silent = true, desc = "CodeCompanion actions" },
      { mode = "n", "<leader>:", ":CodeCompanionCmd ", desc = "CodeCompanionCmd" },
      { mode = "v", "ga", ":CodeCompanionChat Add<CR>", silent = true, desc = "CodeCompanion add" },
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
