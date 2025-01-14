return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lspconfig = require("lspconfig")
    local mason_lspconfig = require("mason-lspconfig")

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf, silent = true }

        -- set keybinds
        opts.desc = "Show LSP references"
        vim.keymap.set("n", "gr", function()
          require("fzf-lua").lsp_references({ jump_to_single_result = true })
        end, opts) -- show definition, references

        opts.desc = "Go to declaration"
        vim.keymap.set("n", "gk", vim.lsp.buf.declaration, opts) -- go to declaration

        opts.desc = "Show LSP definitions"
        vim.keymap.set("n", "gd", function()
          require("fzf-lua").lsp_definitions({ jump_to_single_result = true })
        end, opts) -- show lsp definitions

        opts.desc = "Show LSP implementations"
        vim.keymap.set("n", "gi", function()
          require("fzf-lua").lsp_implementations({ jump_to_single_result = true })
        end, opts) -- show lsp implementations

        opts.desc = "Show LSP type definitions"
        vim.keymap.set("n", "gt", function()
          require("fzf-lua").lsp_typedefs()
        end, opts) -- show lsp type definitions

        opts.desc = "See available code actions"
        vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

        opts.desc = "Smart rename"
        vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, opts) -- smart rename

        opts.desc = "Show buffer diagnostics"
        vim.keymap.set("n", "gb", function()
          require("fzf-lua").diagnostics_document()
        end, opts) -- show  diagnostics for file

        opts.desc = "Show line diagnostics"
        vim.keymap.set("n", "gl", vim.diagnostic.open_float, opts) -- show diagnostics for line

        opts.desc = "Go to previous diagnostic"
        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

        opts.desc = "Go to next diagnostic"
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

        opts.desc = "Show documentation for what is under cursor"
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

        opts.desc = "Restart LSP"
        vim.keymap.set("n", "<leader>lr", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
      end,
    })

    -- used to enable autocompletion (assign to every lsp server config)
    local capabilities = require("blink.cmp").get_lsp_capabilities()

    -- Change the Diagnostic symbols in the sign column (gutter)
    local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    mason_lspconfig.setup_handlers({
      -- default handler for installed servers
      function(server_name)
        lspconfig[server_name].setup({
          capabilities = capabilities,
        })
      end,

      -- custom handlers for specific servers
      ["eslint"] = function()
        lspconfig["eslint"].setup({
          capabilities = capabilities,
          filetypes = { "javascript", "typescript", "typescriptreact", "javascriptreact" },
          on_attach = function(_, bufnr)
            vim.api.nvim_create_autocmd("BufWritePre", {
              buffer = bufnr,
              command = "EslintFixAll",
            })
          end,
        })
      end,
      ["emmet_language_server"] = function()
        lspconfig["emmet_language_server"].setup({
          capabilities = capabilities,
          filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss" },
        })
      end,
      ["lua_ls"] = function()
        lspconfig["lua_ls"].setup({
          capabilities = capabilities,
          settings = {
            Lua = {
              -- make the language server recognize "vim" global
              diagnostics = {
                globals = { "vim" },
              },
              completion = {
                callSnippet = "Replace",
              },
            },
          },
        })
      end,
      ["taplo"] = function()
        lspconfig["taplo"].setup({
          capabilities = capabilities,
          filetypes = { "toml" },
          settings = {
            evenBetterToml = {
              formatter = {
                inlineTableExpand = false,
              },
            },
          },
        })
      end,
    })

    ------------------
    -- error lens
    ------------------
    vim.diagnostic.config({
      virtual_text = true,
    })

    ------------------
    -- inlay hints
    ------------------
    vim.lsp.inlay_hint.enable() -- enabled by default
    vim.keymap.set("n", "<leader>&", function()
      local enabled_icon = "✅"
      local disabled_icon = "❌"
      local current_state = vim.lsp.inlay_hint.is_enabled()
      local icon = current_state and disabled_icon or enabled_icon
      local message = current_state and "Inlay hints disabled" or "Inlay hints enabled"
      vim.lsp.inlay_hint.enable(not current_state)
      print(icon .. " " .. message)
    end, { noremap = true, silent = false, desc = "Toggle inlay hints" })
  end,
}
