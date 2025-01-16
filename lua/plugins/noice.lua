-- https://github.com/folke/noice.nvim/wiki/A-Guide-to-Messages#showmode
return {
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    keys = {
      {
        "<leader>nm",
        ":messages<CR>",
        desc = "Show messages",
      },
    },
    opts = {},
  },
}
