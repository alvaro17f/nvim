return {
  "m4xshen/hardtime.nvim",
  dependencies = { "MunifTanjim/nui.nvim" },
  opts = {
    disabled_keys = {
      ["<Up>"] = {},
      ["<Down>"] = {},
      ["<Left>"] = {},
      ["<Right>"] = {},
    },
    disabled_filetypes = {
      "qf",
      "netrw",
      "NvimTree",
      "lazy",
      "mason",
      "grug-far",
      "lazydo",
      "lazygit",
      "minifiles",
      "snacks_dashboard",
      "snacks_terminal",
      "snacks_picker_input",
      "yazi",
      "trouble",
      "Trouble",
      "diffview",
      "checkhealth",
      "dapui",
      "lspinfo",
      "noice",
      "minifiles",
      "notify",
      "prompt",
    },
  },
}
