return {
	"phaazon/hop.nvim",
	keys = {
		{ mode = "n", "<leader>f", ":HopChar1<CR>", silent = false, desc = "find character" },
	},
	config = function()
		require("hop").setup()
	end,
}
