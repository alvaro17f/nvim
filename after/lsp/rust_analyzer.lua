---@type vim.lsp.Config
return {
  settings = {
    ["rust-analyzer"] = {
      diagnostics = {
        enable = true,
      },
      checkOnSave = true,
      check = {
        enable = true,
        command = "clippy",
        features = "all",
      },
      procMacro = {
        enable = true,
      },
    },
  },
}
