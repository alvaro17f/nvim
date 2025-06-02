return {
  cmd = { "ols" },
  filetypes = { "odin" },
  root_markers = { "ols.json", ".git", "main.odin", ".odin" },
  init_options = {
    checker_args = "-vet -strict-style",
    enable_fake_methods = true,
    enable_hover = true,
    enable_inlay_hints = true,
    enable_references = true,
  },
}
