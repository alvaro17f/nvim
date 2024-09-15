--https://github.com/nvim-lualine/lualine.nvim/blob/master/THEMES.md
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
				--theme = 'rose-pine',
				--theme = 'poimandres',
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch" },
				lualine_c = { "filename" },
				lualine_x = {
					"diagnostics",
					"diff",
					"filetype",
					{
						require("noice").api.statusline.mode.get,
						cond = require("noice").api.statusline.mode.has,
						color = { fg = "#ff9e64" },
					}, --showmode
				},
				lualine_y = { "encoding" },
				lualine_z = { "progress", "location" },
			},
		})
	end,
}
