---@type vim.lsp.Config
return {
  settings = {
    json = {
      schemas = {
        {
          description = "Babel",
          fileMatch = { ".babelrc", ".babelrc.json", "babel.config.json" },
          url = "https://json.schemastore.org/babelrc.json",
        },
        {
          description = "ESLint",
          fileMatch = { ".eslintrc", ".eslintrc.json" },
          url = "https://json.schemastore.org/eslintrc.json",
        },
        {
          description = "Manifest",
          fileMatch = { "manifest.json", "manifest.webmanifest" },
          url = "https://json.schemastore.org/web-manifest-combined.json",
        },
        {
          description = "Package.json",
          fileMatch = { "package.json" },
          url = "https://json.schemastore.org/package.json",
        },
        {
          description = "Prettier",
          fileMatch = {
            ".prettierrc",
            ".prettierrc.json",
            "prettier.config.json",
          },
          url = "https://json.schemastore.org/prettierrc.json",
        },
        {
          description = "TSConfig",
          fileMatch = { "tsconfig*.json" },
          url = "https://json.schemastore.org/tsconfig.json",
        },
      },
    },
  },
}
