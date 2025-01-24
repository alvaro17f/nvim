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
      preset = {
        bottom_search = true,
        command_palette = true,
        lsp_doc_border = true,
      },
      cmdline = {
        view = "cmdline",
        format = {
          search_down = {
            view = "cmdline",
          },
          search_up = {
            view = "cmdline",
          },
        },
      },

      lsp = {
        hover = {
          enabled = false,
        },
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
        },
        signature = {
          enabled = false, -- provided by blink.cmp
        },
      },
    },
  },
}
