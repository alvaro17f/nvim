return {
  "snacks.nvim",
  keys = {
    {
      "<leader>e",
      function()
        Snacks.explorer({ cwd = vim.fs.root(0, { ".git" }) })
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
        },
      },
    },
  },
}
