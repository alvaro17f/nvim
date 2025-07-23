local provider = vim.g.ai

local codecompanion_cmd = function()
  local user_input = vim.fn.input("CodeCompanionCmd: ")
  vim.cmd("CodeCompanionCmd " .. user_input)
end

return {
  "olimorris/codecompanion.nvim",
  lazy = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "franco-ruggeri/codecompanion-spinner.nvim",
  },
  keys = {
    { mode = "n", "<leader>oa", "<CMD>CodeCompanionChat Toggle<CR>", silent = true, desc = "CodeCompanion toggle" },
    { mode = "v", "<leader>oa", "<CMD>CodeCompanionActions<CR>", silent = true, desc = "CodeCompanion actions" },
    { mode = "n", "<leader>:", codecompanion_cmd, desc = "CodeCompanionCmd" },
    { mode = "v", "<leader>oA", "<CMD>CodeCompanionChat Add<CR>", silent = true, desc = "CodeCompanion add" },
    {
      mode = "n",
      "<leader>oc",
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
              ["X-Title"] = "codecompanion",
              ["HTTP-Referer"] = "https://neovim.io",
            },
            schema = {
              model = {
                default = vim.env.OPENROUTER_MODEL or "openrouter/auto",
              },
              temperature = {
                default = 0.5,
              },
            },
          })
        end,
      },
      extensions = {
        spinner = {},
      },
    })
  end,
}
