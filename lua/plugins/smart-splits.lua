return {
  "mrjones2014/smart-splits.nvim",
  --  build = "./kitty/install-kittens.bash",
  event = "VeryLazy",
  -- stylua: ignore
  keys = {
    { "<A-Left>",  function() require("smart-splits").resize_left() end,       desc = "Resize Left" },
    { "<A-Down>",  function() require("smart-splits").resize_down() end,       desc = "Resize Down" },
    { "<A-Up>",    function() require("smart-splits").resize_up() end,         desc = "Resize Up" },
    { "<A-Right>", function() require("smart-splits").resize_right() end,      desc = "Resize Right" },
    { "<C-h>",     function() require("smart-splits").move_cursor_left() end,  desc = "Move Cursor Left" },
    { "<C-j>",     function() require("smart-splits").move_cursor_down() end,  desc = "Move Cursor Down" },
    { "<C-k>",     function() require("smart-splits").move_cursor_up() end,    desc = "Move Cursor Up" },
    { "<C-l>",     function() require("smart-splits").move_cursor_right() end, desc = "Move Cursor Right" },
    { "<leader><leader>h",  function() require("smart-splits").swap_buf_left() end,     desc = "Swap Buffer Left" },
    { "<leader><leader>j",  function() require("smart-splits").swap_buf_down() end,     desc = "Swap Buffer Down" },
    { "<leader><leader>k",    function() require("smart-splits").swap_buf_up() end,       desc = "Swap Buffer Up" },
    { "<leader><leader>l", function() require("smart-splits").swap_buf_right() end,    desc = "Swap Buffer Right" },
  },
}
