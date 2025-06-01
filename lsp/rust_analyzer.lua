return {
  cmd = { "rust-analyzer" },
  filetypes = { "rust" },
  root_markers = { "Cargo.toml", ".git" },
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
