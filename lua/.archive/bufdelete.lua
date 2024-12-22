return {
  "famiu/bufdelete.nvim",
  vim.g.bufdelete_buf_filter,
  keys = {
    {
      mode = "n",
      "<c-x>",
      function()
        require("bufdelete").bufdelete(0, true)
      end,
      desc = "Buffer delete",
    },
  },
}
