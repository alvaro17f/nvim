vim.pack.add({ "https://github.com/OXY2DEV/markview.nvim" }, { load = true, confirm = false })

require("markview").setup({
  experimental = { check_rtp_message = false },
  preview = {
    filetypes = vim.g.markdown_filetypes,
    ignore_buftypes = {},
  },
})
