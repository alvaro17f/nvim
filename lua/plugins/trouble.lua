return {
  "folke/trouble.nvim",
  dependencies = {
    "echasnovski/mini.icons",
    "folke/todo-comments.nvim",
  },
  opts = {
    auto_close = true,
    auto_preview = false,
    multiline = false,
    focus = true,

    vim.api.nvim_create_autocmd("BufRead", {
      callback = function(ev)
        if vim.bo[ev.buf].buftype == "quickfix" then
          vim.schedule(function()
            vim.cmd([[cclose]])
            vim.cmd([[Trouble quickfix toggle]])
          end)
        end
      end,
    }),
  },
  cmd = { "Trouble", "TroubleToggle" },
  keys = {
    {
      mode = "n",
      "<leader>xw",
      "<CMD>Trouble diagnostics toggle<CR>",
      silent = true,
      desc = "Trouble: workspace diagnostics",
    },
    {
      mode = "n",
      "<leader>xx",
      "<CMD>Trouble diagnostics toggle filter.buf=0<CR>",
      silent = true,
      desc = "Trouble: document diagnostics",
    },
    {
      mode = "n",
      "<c-q>",
      "<CMD>Trouble quickfix toggle<CR>",
      silent = true,
      desc = "Trouble: quickfix list",
    },
    {
      mode = "n",
      "<leader>xl",
      "<CMD>Trouble loclist toggle<CR>",
      silent = true,
      desc = "Trouble: location list",
    },
    {
      mode = "n",
      "<leader>xt",
      "<CMD>Trouble todo toggle<CR>",
      silent = true,
      desc = "Trouble: TODO",
    },
  },
}
