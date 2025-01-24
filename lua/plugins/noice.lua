-- https://github.com/folke/noice.nvim/wiki/A-Guide-to-Messages#showmode
return {
  {
    "folke/noice.nvim",
    event = { "VeryLazy" },
    keys = {
      {
        "<leader>nm",
        "<CMD>messages<CR>",
        desc = "Show messages",
      },
    },
    opts = {
      presets = {
        bottom_search = true,
        command_palette = true,
        lsp_doc_border = true,
      },
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
        },
      },
    },
  },
}
