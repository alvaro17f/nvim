return {
  {
    "akinsho/toggleterm.nvim",
    name = "toggleterm",
    version = "*",
    keys = {
      { mode = 'n', '<C-\\>', '<CMD>exe v:count1 . "ToggleTerm"<CR>', silent = true, desc = 'Toggle terminal' },
      { mode = 't', '<C-\\>', '<CMD>exe v:count1 . "ToggleTerm"<CR>', silent = true, desc = 'Toggle terminal' },
    },
    opts = {
      size = 20,
      open_mapping = [[<c-\>]],
      hide_numbers = true,
      shade_filetypes = {},
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true,
      insert_mappings = true,
      persist_size = true,
      direction = "horizontal", -- 'vertical' | 'horizontal' | 'tab' | 'float'
      close_on_exit = true,
      shell = vim.o.shell,
      float_opts = {
        border = "curved",
        winblend = 0,
        highlights = {
          border = "Normal",
          background = "Normal",
        },
      },
    },
  }
}
