Pack.add({ "https://github.com/nvim-mini/mini.surround" })

local MiniSurround = require("mini.surround")

MiniSurround.setup({
  mappings = {
    add = "<leader>sa", -- Add surrounding in Normal and Visual modes
    delete = "<leader>sd", -- Delete surrounding
    replace = "<leader>sr", -- Replace surrounding

    find = "", -- Find surrounding (to the right)
    find_left = "", -- Find surrounding (to the left)
    highlight = "", -- Highlight surrounding
    update_n_lines = "", -- Update `n_lines`
    suffix_last = "", -- Suffix to search with "prev" method
    suffix_next = "", -- Suffix to search with "next" method
  },
})
