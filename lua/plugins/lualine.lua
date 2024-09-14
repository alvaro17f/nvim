-- https://github.com/nvim-lualine/lualine.nvim/blob/master/THEMES.md
return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("lualine").setup({
			options = {
				theme = "catppuccin",
				--theme = 'horizon',
				-- theme = 'rose-pine',
				-- theme = 'poimandres',
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch" },
				lualine_c = { "filename" },
				lualine_x = { "diagnostics", "diff", "filetype" },
				lualine_y = { "encoding" },
				lualine_z = { "progress", "location" },
			},
		})
	end,
}
