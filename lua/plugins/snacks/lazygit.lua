return {
  "snacks.nvim",
  keys = {
    {
      "<leader>gg",
      function()
        if require("utils.git").is_git_repo() then
          Snacks.lazygit({ cwd = require("utils.git").get_git_root() })
        elseif vim.bo.filetype == "snacks_dashboard" then
          Snacks.lazygit({ cwd = vim.fn.stdpath("config") })
        else
          print("You're not in a git repository")
        end
      end,
      desc = "Lazygit",
    },
    {
      "<leader>gl",
      function()
        if require("utils.git").is_git_repo() then
          Snacks.lazygit.log({ cwd = require("utils.git").get_git_root() })
        elseif vim.bo.filetype == "snacks_dashboard" then
          Snacks.lazygit.log({ cwd = vim.fn.stdpath("config") })
        else
          print("You're not in a git repository")
        end
      end,
      desc = "Lazygit log",
    },
  },
  opts = {
    lazygit = {
      enabled = true,
      win = {
        style = {
          width = 0,
          height = 0,
        },
      },
      theme = {
        [241] = { fg = "Special" },
        defaultFgColor = { fg = "Normal" },
        activeBorderColor = { fg = "DiagnosticError", bold = true }, -- { fg = "Function", bold = true },
        inactiveBorderColor = { fg = "Comment" },
        optionsTextColor = { fg = "Function" },
        selectedLineBgColor = { bg = "Visual" },
        unstagedChangesColor = { fg = "DiagnosticError" },
        cherryPickedCommitBgColor = { bg = "default" },
        cherryPickedCommitFgColor = { fg = "Identifier" },
        searchingActiveBorderColor = { fg = "MatchParen", bold = true },
      },
    },
  },
}
