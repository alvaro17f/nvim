local M = {}

M.config = {
  win = {
    wo = { winhighlight = "" },
  },
}

M.keymaps = {
  vim.keymap.set("n", "<leader>N", function()
    Snacks.win({
      file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
      width = 0.6,
      height = 0.6,
      wo = {
        spell = false,
        wrap = false,
        signcolumn = "yes",
        statuscolumn = " ",
        conceallevel = 3,
      },
    })
  end, { desc = "News" }),
}

return M
