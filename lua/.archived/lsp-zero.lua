return {
  'VonHeikemen/lsp-zero.nvim',
  name = "lsp_zero",
  lazy = false,
  dependencies = {
    'neovim/nvim-lspconfig',
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'saadparwaiz1/cmp_luasnip',
    'L3MON4D3/LuaSnip',
    "rafamadriz/friendly-snippets",
    'onsails/lspkind.nvim',
  },
  keys = {
    { mode = 'n', '<leader>,', ':Mason<CR>', desc = 'Open mason' },
  },
  config = function()
    local lsp = require('lsp-zero')

    lsp.on_attach(function(client, bufnr)
      local opts = { buffer = bufnr, silent = true, remap = false }

      vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
      vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
      vim.keymap.set("n", "gl", function() vim.diagnostic.open_float() end, opts)
      vim.keymap.set("n", "gp", function() vim.diagnostic.goto_prev() end, opts)
      vim.keymap.set("n", "gn", function() vim.diagnostic.goto_next() end, opts)
      vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end, opts)
      vim.keymap.set("n", "<leader>gws", function() vim.lsp.buf.workspace_symbol() end, opts)
      vim.keymap.set("n", "<leader>a", function() vim.lsp.buf.code_action() end, opts)
      vim.keymap.set("n", "<F2>", function() vim.lsp.buf.rename() end, opts)
      --vim.keymap.set("i", "gs", function() vim.lsp.buf.signature_help() end, opts)
    end)

    require('mason').setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗"
        }
      }
    })

    require('mason-lspconfig').setup({
      ensure_installed = {
        'astro',
        'bashls',
        'biome',
        'cssls',
        'docker_compose_language_service',
        'dockerls',
        'emmet_ls',
        'gopls',
        'html',
        'jsonls',
        'nil_ls',
        'rust_analyzer',
        'sqlls',
        'lua_ls',
        'ols',
        'taplo',
        'ts_ls',
        'yamlls',
        'zls',
      },
      handlers = {
        lsp.default_setup,
        lua_ls = function()
          require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())
        end,
        taplo = function()
          require('lspconfig').taplo.setup({
            settings = {
              evenBetterToml = {
                formatter = {
                  inlineTableExpand = false,
                }
              }
            }
          })
        end,
      }
    })

    local cmp = require('cmp')
    local cmp_select = { behavior = cmp.SelectBehavior.Select }

    require('luasnip.loaders.from_vscode').lazy_load()

    cmp.setup({
      sources = {
        { name = 'nvim_lsp' },
        { name = 'path' },
        { name = 'buffer' },
        { name = 'luasnip' },
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      --formatting = lsp.cmp_format(),
      formatting = {
        fields = { 'abbr', 'kind', 'menu' },
        format = require('lspkind').cmp_format({
          mode = 'symbol',       -- 'text', 'text_symbol', 'symbol_text', 'symbol'
          maxwidth = 50,         -- prevent the popup from showing more than provided characters
          ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead
        })
      },
      mapping = cmp.mapping.preset.insert({
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<Tab>'] = cmp.mapping(function(fallback)
          local suggestion = require("copilot.suggestion")
          if suggestion.is_visible() then
            suggestion.accept()
          elseif cmp.visible() then
            cmp.confirm({ select = true })
          else
            fallback()
          end
        end, { "i", "s" }),
      }),
    })

    ------------------
    -- nvim-autopairs
    ------------------
    local cmp_autopairs = require('nvim-autopairs.completion.cmp')
    cmp.event:on(
      'confirm_done',
      cmp_autopairs.on_confirm_done()
    )

    ------------------
    -- error lens
    ------------------
    vim.diagnostic.config({
      virtual_text = true
    })
  end
}
