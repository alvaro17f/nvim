return {
  'vigoux/notifier.nvim',
  name = "notifier",
  lazy = false,
  keys = {
    { mode = 'n', '<leader>d', '<CMD>NotifierClear<CR>', silent = true, desc = "Dismiss all Notifications" },
  },
  config = function()
    require('notifier').setup()
  end,
}
