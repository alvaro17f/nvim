-- https://github.com/folke/noice.nvim/wiki/A-Guide-to-Messages#showmode
return {
  {
    "folke/noice.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    event = "VeryLazy",
    keys = {
      {
        mode = "n",
        "<leader>nn",
        ":NoiceAll<CR>",
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
  },
  {
    "rcarriga/nvim-notify",
    opts = {
      render = "wrapped-compact",
      stages = "fade_in_slide_out",
    },
  },
}
