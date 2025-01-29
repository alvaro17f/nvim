return {
  "nat-418/boole.nvim",
  config = function()
    ---@diagnostic disable-next-line: missing-fields
    require("boole").setup({
      mappings = {
        increment = "<C-a>",
        decrement = "<C-z>",
      },
      -- User defined loops
      additions = {
        { "Foo", "Bar" },
        { "tic", "tac", "toe" },
      },
      allow_caps_additions = {
        { "enable", "disable" },
        -- enable → disable
        -- Enable → Disable
        -- ENABLE → DISABLE
      },
    })
  end,
}
