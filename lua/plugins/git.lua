if vim.fn.executable("lazygit") == 0 then
	return { vim.notify("Please install 'lazygit'", vim.log.levels.ERROR) }
end

require("utils.lazygit_toggle")
local is_git_repo = require("utils.is_git_repo")

return {
	{
		"lewis6991/gitsigns.nvim",
		lazy = false,
		keys = {
			{
				mode = "n",
				"<leader>gp",
				":Gitsigns preview_hunk_inline<CR>",
				silent = true,
				desc = "Gitsigns Preview Hunk",
			},
		},
		config = function()
			require("gitsigns").setup({
				current_line_blame = true,
			})
		end,
	},
	{
		"sindrets/diffview.nvim",
		cmd = { "DiffviewOpen", "DiffviewFileHistory" },
		keys = {
			{ mode = "n", "<Leader>gd", "<cmd>DiffviewFileHistory %<CR>", silent = true, desc = "Diff File" },
			{ mode = "n", "<Leader>gv", "<cmd>DiffviewOpen<CR>", silent = true, desc = "Diff View" },
		},
		opts = function()
			local actions = require("diffview.actions")
			vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
				group = vim.api.nvim_create_augroup("rafi_diffview", {}),
				pattern = "diffview:///panels/*",
				callback = function()
					vim.opt_local.cursorline = true
					vim.opt_local.winhighlight = "CursorLine:WildMenu"
				end,
			})

			return {
				enhanced_diff_hl = true, -- See ':h diffview-config-enhanced_diff_hl'
				keymaps = {
					view = {
						{ "n", "q", actions.close },
						{ "n", "<Tab>", actions.select_next_entry },
						{ "n", "<S-Tab>", actions.select_prev_entry },
						{ "n", "<LocalLeader>a", actions.focus_files },
						{ "n", "<LocalLeader>e", actions.toggle_files },
					},
					file_panel = {
						{ "n", "q", actions.close },
						{ "n", "h", actions.prev_entry },
						{ "n", "o", actions.focus_entry },
						{ "n", "gf", actions.goto_file },
						{ "n", "sg", actions.goto_file_split },
						{ "n", "st", actions.goto_file_tab },
						{ "n", "<C-r>", actions.refresh_files },
						{ "n", "<LocalLeader>e", actions.toggle_files },
					},
					file_history_panel = {
						{ "n", "q", "<cmd>DiffviewClose<CR>" },
						{ "n", "o", actions.focus_entry },
						{ "n", "O", actions.options },
					},
				},
			}
		end,
	},
	{
		"kdheepak/lazygit.nvim",
		cmd = {
			"LazyGit",
			"LazyGitConfig",
			"LazyGitCurrentFile",
			"LazyGitFilter",
			"LazyGitFilterCurrentFile",
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		lazy = false,
		keys = {
			{
				"<leader>gg",
				function()
					if is_git_repo() then
						vim.cmd("LazyGitToggle")
					end
				end,
				desc = "LazyGit",
			},
		},
	},
}
