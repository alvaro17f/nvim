local is_git_repo = require("utils.is_git_repo")

return {
	"nvim-telescope/telescope.nvim",
	lazy = false,
	dependencies = {
		"nvim-lua/plenary.nvim",
		"davvid/telescope-git-grep.nvim",
	},
	keys = {

		{ mode = "n", "gr", ":Telescope lsp_references<CR>", silent = true, desc = "Telescope references" },
		{ mode = "n", "<C-b>", ":Telescope buffers<CR>", silent = true, desc = "Telescope buffers" },
		{ mode = "n", "<C-BS>", ":Telescope oldfiles<CR>", silent = true, desc = "Telescope recent files" },
		{
			mode = "n",
			"<C-e>",
			require("utils.telescope_files"),
			silent = true,
			desc = "Telescope files",
		},
		{
			mode = "n",
			"<C-f>",

			function()
				if is_git_repo() then
					vim.cmd("Telescope git_grep")
				else
					vim.cmd("Telescope live_grep")
				end
			end,
			silent = true,
			desc = "Telescope grep",
		},
	},
	config = function()
		require("telescope").load_extension("git_grep")
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
					no_ignore = false,
					hidden = true,
				},
				git_files = {
					path_display = { "filename_first" },
					no_ignore = false,
					hidden = true,
				},
				live_grep = {
					path_display = { "filename_first" },
					no_ignore = false,
					hidden = true,
				},
				buffers = {
					path_display = { "filename_first" },
					ignore_current_buffer = true,
					sort_mru = true,
				},
				lsp_references = {
					path_display = { "filename_first" },
					include_current_line = true,
					show_line = false,
				},
			},
		})
	end,
}
