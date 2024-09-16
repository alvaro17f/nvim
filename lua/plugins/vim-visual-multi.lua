return {
  "mg979/vim-visual-multi",
  keys = {
    { mode = "v", "<tab>", "<Plug>(VM-Switch-Mode)", silent = true, desc = "Switch Mode" },
    { mode = "n", "<C-n>", "<Plug>(VM-Find-Under)", silent = true, desc = "Find under" },
    { mode = "v", "<C-n>", "<Plug>(VM-Find-Under)", silent = true, desc = "Find under" },
    { mode = "n", "<C-s>", "<Plug>(VM-Skip-Region)", silent = true, desc = "Skip region" },
    { mode = "n", "<C-p>", "<Plug>(VM-Remove-Region)", silent = true, desc = "Remove region" },
    { mode = "n", "<a-k>", "<Plug>(VM-Add-Cursor-Up)", silent = true, desc = "Add cursor down" },
    { mode = "n", "<a-j>", "<Plug>(VM-Add-Cursor-Down)", silent = true, desc = "Add cursor down" },
  },
  config = function()
    vim.g.VM_default_mappings = 0
    vim.g.VM_mouse_mappings = 1
  end,
}
