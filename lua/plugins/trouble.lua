return {
	"folke/trouble.nvim",
	cmd = "Trouble",
	keys = {
		{
			mode = "n",
			"X",
			"<cmd>Trouble diagnostics toggle focus=true<cr>",
			silent = true,
			desc = "Trouble diagnostics",
		},
	},
}
