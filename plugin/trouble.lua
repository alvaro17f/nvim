vim.pack.add({ "https://github.com/folke/trouble.nvim" }, { load = true, confirm = false })

require("trouble").setup({
  auto_close = true,
  auto_preview = false,
  multiline = false,
  focus = true,
})

vim.api.nvim_create_autocmd("BufRead", {
  callback = function(ev)
    if vim.bo[ev.buf].buftype == "quickfix" then
      vim.schedule(function()
        vim.cmd([[cclose]])
        vim.cmd([[Trouble quickfix toggle]])
      end)
    end
  end,
})

  --stylua: ignore start
  vim.keymap.set("n", "<leader>xw", "<CMD>Trouble diagnostics toggle<CR>", {desc = "Trouble: workspace diagnostics"})
  vim.keymap.set("n", "<leader>xx", "<CMD>Trouble diagnostics toggle filter.buf=0<CR>", {desc = "Trouble: document diagnostics"})
  vim.keymap.set("n", "<c-q>", "<CMD>Trouble quickfix toggle<CR>", {desc = "Trouble: quickfix list"})
  vim.keymap.set("n", "<leader>xl", "<CMD>Trouble loclist toggle<CR>", {desc = "Trouble: quickfix list"})
  vim.keymap.set("n", "<leader>xt", "<CMD>Trouble todo toggle<CR>", {desc = "Trouble: TODO"})
--stylua: ignore end
