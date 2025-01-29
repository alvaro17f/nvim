return {
  "kosayoda/nvim-lightbulb",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    ---@diagnostic disable-next-line: missing-fields
    require("nvim-lightbulb").setup({
      autocmd = { enabled = true },
    })
  end,
}
