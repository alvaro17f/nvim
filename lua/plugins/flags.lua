return {

  require("utils.flags").setup({
    vim.keymap.set("n", "<leader>F", "<CMD>Flags<CR>", { silent = true, desc = "Open Flags" }),
    flags = {
      copilot = true,
      debugger = true,
    },
  }),
}
