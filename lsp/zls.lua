vim.g.zig_fmt_parse_errors = 0
vim.g.zig_fmt_autosave = 0

return {
  cmd = { "zls" },
  filetypes = { "zig", "zir", "zon" },
  root_markers = { "zls.json", "build.zig", "build.zig.zon", ".git" },
  settings = {
    zls = {
      semantic_tokens = "partial",
    },
  },
}
