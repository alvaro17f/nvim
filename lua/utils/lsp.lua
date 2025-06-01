local M = {}

local get_lsp_servers = function()
  local servers = {}

  -- vim.api.nvim_get_runtime_file("lsp/*", true)
  for _, v in ipairs(vim.fn.readdir(os.getenv("HOME") .. "/.config/nvim/lsp")) do
    local name = vim.fn.fnamemodify(v, ":t:r")
    table.insert(servers, name)
  end

  return servers
end

M.setup_mason = function(LSP_TOOLS, DEBUGGERS)
  local tools = {}

  if vim.g.debugger then
    vim.list_extend(tools, DEBUGGERS)
  end

  vim.list_extend(tools, LSP_TOOLS)

  require("mason-tool-installer").setup({ ensure_installed = tools })

  local servers = get_lsp_servers()
  -- if using mason-lspconfig:
  require("mason-lspconfig").setup({ ensure_installed = servers, automatic_enable = true })
  -- otherwise:
  -- vim.lsp.enable(servers)
end

M.setup_keybindings = function()
  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(event)
      local opts = { buffer = event.buf, silent = true }

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

      opts.desc = "Show documentation for what is under cursor"
      vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

      opts.desc = "Restart LSP"
      vim.keymap.set("n", "grl", "<CMD>LspRestart<CR>", opts)
    end,
  })
end

M.setup_diagnostics = function()
  local signs = { ERROR = " ", WARN = " ", HINT = "󰠠 ", INFO = " " }
  local diagnostic_signs = {}
  for type, icon in pairs(signs) do
    diagnostic_signs[vim.diagnostic.severity[type]] = icon
  end

  vim.diagnostic.config({
    float = { border = "rounded" },
    severity_sort = true,
    signs = diagnostic_signs,
    underline = true,
    update_in_insert = false,
    virtual_text = {
      spacing = 4,
      source = "if_many",
      prefix = "●",
    },
  })
end

M.setup_inlay_hints = function(enabled_by_default)
  if enabled_by_default then
    vim.lsp.inlay_hint.enable()
  end

  vim.keymap.set("n", "<leader>&", function()
    local current_state = vim.lsp.inlay_hint.is_enabled()
    local icon = current_state and " " or " "
    local message = current_state and "Inlay hints disabled" or "Inlay hints enabled"
    vim.lsp.inlay_hint.enable(not current_state)
    print(icon .. " " .. message)
  end, { noremap = true, silent = false, desc = "Toggle inlay hints" })
end

return M
