local cwd = require("utils.git").get_workspace_root()

return {
  "snacks.nvim",
  keys = {
    {
      "<leader>e",
      function()
        Snacks.explorer()
      end,
      desc = "Picker: explorer",
    },
  },
  opts = {
    explorer = {
      replace_netrw = false,
    },
    picker = {
      sources = {
        explorer = {
          auto_close = true,
          hidden = true,
          cwd = cwd,
          win = {
            list = {
              keys = {
                ["h"] = "explorer_up",
                ["l"] = "explorer_cd",
              },
            },
          },
        },
      },
    },
  },
}
