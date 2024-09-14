return {
  "lukas-reineke/indent-blankline.nvim",
  name = "ibl",
  event = { "BufReadPost", "BufNewFile" },
  main = "ibl",
  config = function()
    require("ibl").setup {
      indent = { char = "│" },
      scope = { enabled = false },
      exclude = {
        filetypes = {
          "help",
          "alpha",
          "dashboard",
          "neo-tree",
          "Trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
          "lazyterm",
        },
      },
    }
  end
}
