-- https://github.com/folke/noice.nvim/wiki/A-Guide-to-Messages#showmode
return {
	"folke/noice.nvim",
	event = "VeryLazy",
	opts = {},
	keys = {
		{
			mode = "n",
			"<leader>d",
			"<CMD>Noice dismiss<CR>",
			{ silent = true, pending = true },
			desc = "Dismiss all Notifications",
		},
	},
	dependencies = {
		"MunifTanjim/nui.nvim",
		--"rcarriga/nvim-notify", --if you want to use the notification view.
	},
	config = function()
		require("noice").setup()
	end,
}
