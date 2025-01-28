if not vim.g.copilot then
  return {}
end

local plugins = {}

local provider = vim.g.copilot

local codecompanion_cmd = function()
  local user_input = vim.fn.input("CodeCompanionCmd: ")
  vim.cmd("CodeCompanionCmd " .. user_input)
end

local codecompanion = {
  "olimorris/codecompanion.nvim",
  lazy = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  keys = {
    { mode = "n", "<leader>a", "<CMD>CodeCompanionChat Toggle<CR>", silent = true, desc = "CodeCompanion toggle" },
    { mode = "v", "<leader>a", "<CMD>CodeCompanionActions<CR>", silent = true, desc = "CodeCompanion actions" },
    { mode = "n", "<leader>:", codecompanion_cmd, desc = "CodeCompanionCmd" },
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
            name = "openai",
            env = {
              api_key = "OPENAI_API_KEY",
            },
          })
        end,
        openrouter = function()
          return require("codecompanion.adapters").extend("openai_compatible", {
            name = "openrouter",
            env = {
              url = "https://openrouter.ai/api",
              api_key = "OPENROUTER_API_KEY",
            },
            headers = {
              ["X-Title"] = "Neovim - CodeCompanion",
              ["HTTP-Referer"] = "https://neovim.io",
            },
            schema = {
              model = {
                default = "deepseek/deepseek-r1-distill-llama-70b",
              },
              temperature = {
                default = 0.5,
              },
            },
          })
        end,
      },
    })
  end,
}

local copilot = {
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
}

if vim.g.copilot == "copilot" then
  table.insert(plugins, copilot)
end

table.insert(plugins, codecompanion)

return plugins
