return {
  "stevearc/aerial.nvim",
  event = { "BufReadPre", "BufNewFile" },
  keys = {
    { mode = "n", "|", "<cmd>AerialToggle<cr>", desc = "Aerial: Toggle" },
  },
  opts = {
    close_on_select = true,
    on_attach = function(bufnr)
      vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
      vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
    end,
  },
}
