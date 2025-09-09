vim.pack.add({
  { src = "https://github.com/chomosuke/typst-preview.nvim" },
}, { load = true, confirm = false })

vim.api.nvim_create_autocmd("BufEnter", {
  desc = "Typst",
  pattern = { "*.typ" },
  callback = function()
    local typst_preview = require("typst-preview")

    typst_preview.setup({})

    vim.keymap.set("n", "<leader>T", "<CMD>TypstPreviewToggle<CR>", { desc = "Typst preview toggle" })
  end,
})
