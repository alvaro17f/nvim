-- https://github.com/nvimtools/none-ls.nvim/blob/main/doc/BUILTINS.md
return {
	{
		"jay-babu/mason-null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"nvimtools/none-ls.nvim",
			"nvimtools/none-ls-extras.nvim",
		},
		config = function()
			require("mason")

			local null_ls = require("null-ls")
			null_ls.setup({
				sources = {
					null_ls.builtins.formatting.stylua,
					null_ls.builtins.diagnostics.markdownlint,
					require("none-ls.diagnostics.eslint_d"),
					null_ls.builtins.formatting.prettier,
					null_ls.builtins.formatting.biome,
					null_ls.builtins.diagnostics.golangci_lint,
					null_ls.builtins.formatting.goimports_reviser,
				},
			})

			require("mason-null-ls").setup({
				ensure_installed = {
					"ast_grep",
				},
				automatic_installation = true,
			})
		end,
	},

	--{
	--"nvimtools/none-ls.nvim",
	--config = function()
	--local null_ls = require("null-ls")
	--null_ls.setup({
	--sources = {
	--null_ls.builtins.formatting.stylua,
	--null_ls.builtins.formatting.prettier,
	--null_ls.builtins.formatting.biome,
	--null_ls.builtins.diagnostics.golangci_lint,
	--null_ls.builtins.formatting.goimports_reviser,
	--null_ls.builtins.diagnostics.markdownlint,
	--},
	--})
	--end,
	--},
}
