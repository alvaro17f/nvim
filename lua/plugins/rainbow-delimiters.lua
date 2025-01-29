return {
  "HiPhish/rainbow-delimiters.nvim",
  event = "VeryLazy",
  config = function()
    -- patch https://github.com/nvim-treesitter/nvim-treesitter/issues/1124
    if vim.fn.expand("%:p") ~= "" then
      vim.cmd.edit({ bang = true })
    end
  end,
}
