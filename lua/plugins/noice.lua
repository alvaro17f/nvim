-- https://github.com/folke/noice.nvim/wiki/A-Guide-to-Messages#showmode
return {
  "folke/noice.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim",
    -- "rcarriga/nvim-notify", --if you want to use the notification view.
  },
  event = "VeryLazy",
  keys = {
    {
      mode = "n",
      "<leader>nn",
      ":NoiceFzf<CR>",
      { silent = true, pending = true },
      desc = "Show all Notifications",
    },
    {
      mode = "n",
      "<leader>nd",
      ":Noice dismiss<CR>",
      { silent = true, pending = true },
      desc = "Dismiss all Notifications",
    },
  },
  opts = {},
}
