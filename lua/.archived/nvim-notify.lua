return {
  "rcarriga/nvim-notify",
  name = "notify",
  lazy = false,
  keys = {
    {
      mode = 'n',
      '<leader>d',
      function()
        require("notify").dismiss({ silent = true, pending = true })
      end,
      desc = "Dismiss all Notifications",
    },
  },
  config = function()
    require("notify").setup()
    vim.notify = require("notify")
  end,
}
