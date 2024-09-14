return {
	"nvim-pack/nvim-spectre",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	keys = {
		{
			mode = "n",
			"<c-s-f>",
			'<cmd>lua require("spectre").open_file_search({select_word=true})<CR>',
			desc = "Search and replace",
		},
		{
			mode = "v",
			"<c-s-f>",
			'<esc><cmd>lua require("spectre").open_file_search({select_word=true})<CR>',
			desc = "Search and replace",
		},
	},
	config = function()
		require("spectre").setup({ is_block_ui_break = true })
	end,
}
