return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    "windwp/nvim-ts-autotag",
    "nvim-treesitter/nvim-treesitter-context",
  },
  event = { "BufReadPre", "BufNewFile" },
  build = ":TSUpdate",
  config = function()
    local treesitter = require("nvim-treesitter.configs")
    local autotag = require("nvim-ts-autotag")
    local context = require("treesitter-context")

    treesitter.setup({
      auto_install = true,
      ensure_installed = { "regex" },
      highlight = { enable = true },
      indent = { enable = true },
    })

    autotag.setup({
      opts = {
        enable_close = true, -- Auto close tags
        enable_rename = true, -- Auto rename pairs of tags
        enable_close_on_slash = false, -- Auto close on trailing </
      },
    })

    context.setup({
      enable = true,
      mode = "cursor", -- 'cursor' 'topline'
      max_lines = 3,
    })
  end,
}
