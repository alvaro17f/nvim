return {
  "famiu/bufdelete.nvim",
  vim.g.bufdelete_buf_filter,
  keys = {
    {
      mode = "n",
      "<c-c>",
      function()
        require("bufdelete").bufdelete(0, true)
      end,
      desc = "Buffer delete",
    },
  },
}
