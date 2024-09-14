return {
	"windwp/nvim-autopairs",
	name = "nvim_autopairs",
	config = function()
		require("nvim-autopairs").setup({})
		require("cmp").event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done())
	end,
}
