_G.Utils = _G.Utils or {}
_G.Utils.lsp = _G.Utils.lsp or {}

local set_global_config = function()
  local capabilities = vim.lsp.protocol.make_client_capabilities()

  local ok, blink = pcall(require, "blink.cmp")
  if ok then
    capabilities = blink.get_lsp_capabilities(nil, true)
    capabilities.textDocument.onTypeFormatting = { dynamicRegistration = false }
  end

  vim.lsp.config("*", {
    capabilities = capabilities,
  })
end

local get_lsp_servers = function()
  local files = Flags.mason
      and vim.tbl_map(function(file)
        return vim.fn.stdpath("config") .. "/after/lsp/" .. file
      end, vim.fn.readdir(vim.fn.stdpath("config") .. "/after/lsp"))
    or vim.api.nvim_get_runtime_file("lsp/*.lua", true)

  return vim
    .iter(files)
    :map(function(file)
      return vim.fn.fnamemodify(file, ":t:r")
    end)
    :totable()
end

---@param LSP_TOOLS string[]
---@param DEBUGGERS string[]
local enable = function(LSP_TOOLS, DEBUGGERS)
  Pack.add({ "https://github.com/neovim/nvim-lspconfig" })

  local servers = get_lsp_servers()

  if Flags.mason then
    Pack.add({
      "https://github.com/mason-org/mason.nvim",
      "https://github.com/mason-org/mason-lspconfig.nvim",
      "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
    })

    local mason = require("mason")
    local mason_tool_installer = require("mason-tool-installer")
    local mason_lspconfig = require("mason-lspconfig")

    mason.setup({
      ui = {
        icons = Utils.icons.mason,
      },
    })

    vim.keymap.set("n", "<leader>,", "<CMD>Mason<CR>", { desc = "Open mason" })

    local tools = {}

    if Flags.debugger then
      vim.list_extend(tools, DEBUGGERS)
    end

    vim.list_extend(tools, LSP_TOOLS)

    mason_tool_installer.setup({ ensure_installed = tools })
    mason_lspconfig.setup({ ensure_installed = servers, automatic_enable = true })
  else
    vim.lsp.enable(servers)
  end
end

local on_attach = function()
  vim.api.nvim_create_autocmd("LspAttach", {
    desc = "LSP Setup",
    callback = function(args)
      local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
      local methods = vim.lsp.protocol.Methods
      local opts = { noremap = true, silent = true, buffer = args.buf }

      opts.desc = "Go to declaration"
      vim.keymap.set("n", "gk", vim.lsp.buf.declaration, opts)

      opts.desc = "Show LSP definitions"
      vim.keymap.set("n", "gd", function()
        Snacks.picker.lsp_definitions()
      end, opts)

      opts.desc = "Show LSP references"
      vim.keymap.set("n", "grr", function()
        Snacks.picker.lsp_references()
      end, opts)

      opts.desc = "See available code actions"
      vim.keymap.set({ "n", "v" }, "gra", vim.lsp.buf.code_action, opts)

      opts.desc = "Show LSP implementations"
      vim.keymap.set("n", "gri", function()
        Snacks.picker.lsp_implementations()
      end, opts)

      opts.desc = "Smart rename"
      vim.keymap.set("n", "grn", vim.lsp.buf.rename, opts)

      opts.desc = "Show LSP type definitions"
      vim.keymap.set("n", "gt", function()
        Snacks.picker.lsp_type_definitions()
      end, opts)

      opts.desc = "Show buffer diagnostics"
      vim.keymap.set("n", "gb", function()
        Snacks.picker.diagnostics_buffer()
      end, opts)

      opts.desc = "Show line diagnostics"
      vim.keymap.set("n", "gl", vim.diagnostic.open_float, opts)

      opts.desc = "Go to previous diagnostic"
      vim.keymap.set("n", "[d", function()
        vim.diagnostic.jump({ count = -1, float = true })
      end, opts)

      opts.desc = "Go to next diagnostic"
      vim.keymap.set("n", "]d", function()
        vim.diagnostic.jump({ count = 1, float = true })
      end, opts)

      opts.desc = "Go to previous error"
      vim.keymap.set("n", "[e", function()
        vim.diagnostic.jump({ count = -1, float = true, severity = vim.diagnostic.severity.ERROR })
      end, opts)

      opts.desc = "Go to next error"
      vim.keymap.set("n", "]e", function()
        vim.diagnostic.jump({ count = 1, float = true, severity = vim.diagnostic.severity.ERROR })
      end, opts)

      opts.desc = "Show documentation for what is under cursor"
      vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

      opts.desc = "Restart LSP"
      vim.keymap.set("n", "grl", "<CMD>LspRestart<CR>", opts)

      if client:supports_method(methods.textDocument_competion, args.buf) then
        if vim.g.autocomplete then
          vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })

          opts.desc = "Trigger completion"
          vim.keymap.set("i", "<c-space>", function()
            vim.lsp.completion.get()
          end, opts)
        end

        if client:supports_method(methods.textDocument_documentColor, args.buf) then
          vim.lsp.document_color.enable(true, args.buf, { style = "virtual" })
        end
      end

      if client:supports_method(methods.textDocument_inlayHint, args.buf) then
        if vim.g.inlayhints then
          vim.lsp.inlay_hint.enable()
        end

        opts.desc = "Toggle inlay hints"
        vim.keymap.set("n", "<leader>&", function()
          local current_state = vim.lsp.inlay_hint.is_enabled()
          local icon = current_state and Utils.icons.core.toggle.disabled or Utils.icons.core.toggle.enabled
          local message = current_state and "Inlay hints disabled" or "Inlay hints enabled"
          vim.lsp.inlay_hint.enable(not current_state)
          print(icon .. " " .. message)
        end, opts)
      end

      if client:supports_method(methods.textDocument_onTypeFormatting, args.buf) then
        vim.lsp.on_type_formatting.enable(true, { client_id = client.id })
      end
    end,
  })
end

local diagnostics = function()
  local diagnostic_signs = {}
  for type, icon in pairs(Utils.icons.diagnostics) do
    diagnostic_signs[vim.diagnostic.severity[type:upper()]] = icon
  end

  vim.diagnostic.config({
    float = { border = "rounded" },
    severity_sort = true,
    signs = {
      text = diagnostic_signs,
    },
    underline = true,
    update_in_insert = false,
    virtual_text = {
      spacing = 4,
      source = "if_many",
      prefix = Utils.icons.core.bullet,
    },
  })
end

---@param LSP_TOOLS string[]
---@param DEBUGGERS string[]
Utils.lsp.setup = function(LSP_TOOLS, DEBUGGERS)
  set_global_config()
  enable(LSP_TOOLS, DEBUGGERS)
  on_attach()
  diagnostics()
end
