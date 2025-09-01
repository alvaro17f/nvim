---@type vim.lsp.Config
return {
  settings = {
    Lua = {
      diagnostics = {
        enable = true,
        globals = {
          "vim",
          "Snacks",
        },
      },
    },
  },
}
