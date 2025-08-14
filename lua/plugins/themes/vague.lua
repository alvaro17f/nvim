return {
  "vague2k/vague.nvim",
  name = "vague",
  lazy = false,
  priority = 1000,
  opts = {
    transparent = true, -- don't set background
  },
  config = function(_, opts)
    require("vague").setup(opts)
    vim.cmd.colorscheme("vague")
  end,
}
