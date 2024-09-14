return {
	"nvim-telescope/telescope.nvim",
	lazy = false,
	dependencies = { "nvim-lua/plenary.nvim" },
	keys = {
		{ mode = "n", "<C-f>", ":Telescope live_grep<CR>", silent = true, desc = "Telescope grep" },
		{ mode = "n", "<C-b>", ":Telescope buffers<CR>", silent = true, desc = "Telescope buffers" },
		{
			mode = "n",
			"<C-e>",
			require("utils.telescope_files"),
			silent = true,
			desc = "Telescope files",
		},
	},
	config = function()
		local actions = require("telescope.actions")
		require("telescope").setup({
			defaults = {
				mappings = {
					n = {
						["<c-x>"] = actions.delete_buffer,
					},
					i = {
						["<esc>"] = actions.close,
						["<c-j>"] = actions.move_selection_next,
						["<c-k>"] = actions.move_selection_previous,
						["<c-x>"] = actions.delete_buffer,
					},
				},
			},
			pickers = {
				find_files = {
					path_display = { "filename_first" },
				},
				git_files = {
					path_display = { "filename_first" },
				},
				live_grep = {
					path_display = { "filename_first" },
				},
				buffers = {
					path_display = { "filename_first" },
					ignore_current_buffer = true,
					sort_lastused = true,
				},
			},
		})
	end,
}
