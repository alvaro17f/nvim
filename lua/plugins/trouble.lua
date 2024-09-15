return {
	"folke/trouble.nvim",
	opts = {},
	cmd = "Trouble",
  --stylua: ignore
  keys = {
    { mode = "n", "X", "<cmd>Trouble diagnostics toggle focus=true<cr>", silent = true, desc = "Trouble diagnostics" },
  },
}
