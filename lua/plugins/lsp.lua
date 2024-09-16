---@diagnostic disable: unused-local
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
local LSP_SERVERS = {
	"astro",
	"bashls",
	"biome",
	"cssls",
	"docker_compose_language_service",
	"dockerls",
	"emmet_ls",
	"gopls",
	"html",
	"jsonls",
	"nil_ls",
	"rust_analyzer",
	"sqlls",
	"lua_ls",
	"ols",
	"taplo",
	"ts_ls",
	"tailwindcss",
	"yamlls",
	"zls",
}

local LSP_TOOLS = {
	"eslint_d",
	"jq",
	"prettierd",
	"stylua",
}

local LSP_SERVER_CONFIG = {
	taplo = {
		settings = {
			evenBetterToml = {
				formatter = {
					inlineTableExpand = false,
				},
			},
		},
	},
}

return {
	{
		"williamboman/mason.nvim",
		lazy = false,
		config = function()
			require("mason").setup({
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			})
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		opts = {
			auto_install = true,
			ensure_installed = LSP_SERVERS,
		},
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		lazy = false,
		config = function()
			require("mason-tool-installer").setup({
				ensure_installed = LSP_TOOLS,
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		keys = {
			{ mode = "n", "<leader>,", ":Mason<CR>", desc = "Open mason" },
		},
		config = function()
			local lspconfig = require("lspconfig")
			local config = {
				capabilities = require("cmp_nvim_lsp").default_capabilities(),
				on_attach = function(client, bufnr)
					local opts = { buffer = bufnr, silent = true, remap = false }

					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
					vim.keymap.set("n", "gl", vim.diagnostic.open_float, opts)
					vim.keymap.set("n", "gp", vim.diagnostic.goto_prev, opts)
					vim.keymap.set("n", "gn", vim.diagnostic.goto_next, opts)
					vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
					vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action, opts)
					vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, opts)
					--vim.keymap.set("n", "<leader>gws", vim.lsp.buf.workspace_symbol, opts)
					--vim.keymap.set("i", "gs", vim.lsp.buf.signature_help, opts)
				end,
			}

			for _, server in pairs(LSP_SERVERS) do
				if LSP_SERVER_CONFIG[server] then
					config = vim.tbl_deep_extend("force", config, LSP_SERVER_CONFIG[server])
				end

				lspconfig[server].setup(config)
			end

			------------------
			-- error lens
			------------------
			vim.diagnostic.config({
				virtual_text = true,
			})
		end,
	},
}
