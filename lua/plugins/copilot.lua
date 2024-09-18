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
    opts = {
      suggestion = {
        enabled = true,
        auto_trigger = true,
        hide_during_completion = true,
        debounce = 75,
        keymap = {
          accept = "<tab>",
          accept_word = false,
          accept_line = false,
          next = "<s-tab>",
          prev = nil,
          dismiss = nil,
        },
      },
      panel = { enabled = false },
    },
  },
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "hrsh7th/nvim-cmp", -- Optional: For using slash commands and variables in the chat buffer
      "nvim-telescope/telescope.nvim", -- Optional: For using slash commands
      { "stevearc/dressing.nvim", opts = {} }, -- Optional: Improves the default Neovim UI
    },
    keys = {
      { mode = "n", "<leader>a", ":CodeCompanionToggle<CR>", desc = "CodeCompanion toggle" },
      { mode = "v", "<leader>a", ":CodeCompanion<CR>", desc = "CodeCompanion selection" },
      { mode = "v", "<c-a>", ":CodeCompanionActions<CR>", desc = "CodeCompanion actions" },
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
