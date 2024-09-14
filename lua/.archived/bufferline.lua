return {
	"akinsho/bufferline.nvim",
	name = "bufferline",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	lazy = false,
	keys = {
		{ mode = "n", "<c-w>", ":bdelete!<CR>", silent = true, desc = "Delete buffer" },
		{ mode = "n", "<c-t>", ":enew!<CR>", silent = true, desc = "New tab" },
		{ mode = "n", "<c-s-t>", ":tabnew #<CR>", silent = true, desc = "Reopen last tab" },
		{ mode = "n", "<c-l>", ":BufferLineCycleNext<CR>", silent = true, desc = "Next buffer" },
		{ mode = "n", "<c-h>", ":BufferLineCyclePrev<CR>", silent = true, desc = "Previous buffer" },
		{ mode = "n", "<c-a-l>", ":BufferLineMoveNext<CR>", silent = true, desc = "Move buffer next" },
		{ mode = "n", "<c-a-h>", ":BufferLineMovePrev<CR>", silent = true, desc = "Move buffer previous" },
		{ mode = "n", "<leader>o", ":%bd|e#|bd#<CR>", silent = true, desc = "Kill all other buffers" },
	},
	config = function()
		require("bufferline").setup({
			options = {
				separator_style = "slope", -- "slant" | "slope" | "thick" | "thin" | { 'any', 'any' }
				indicator = {
					icon = "▎",
					style = "none", -- 'icon' | 'underline' | 'none',
				},
			},
			highlights = {
				buffer_selected = {
					bold = true,
					fg = "#f38ba8",
				},
			},
		})
	end,
}
