local M = {}

M.config = {
  explorer = {
    replace_netrw = false,
  },
  picker = {
    sources = {
      explorer = {
        auto_close = true,
        hidden = true,
        win = {
          input = {
            keys = {
              ["<Esc>"] = false,
            },
          },
          list = {
            keys = {
              ["<Esc>"] = false,
            },
          },
        },
      },
    },
  },
}

M.keymaps = {
  vim.keymap.set("n", "<leader>e", function()
    Snacks.explorer({ cwd = vim.fs.root(0, { ".git" }) })
  end, { desc = "Explorer" }),
}

return M
