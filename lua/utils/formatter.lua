local first = function(bufnr, ...)
  local conform = require("conform")
  for i = 1, select("#", ...) do
    local formatter = select(i, ...)
    if conform.get_formatter_info(formatter, bufnr).available then
      return formatter
    end
  end
  return select(1, ...)
end

local formatters = {
  biome = function()
    return {
      "biome",
      "biome-check",
      "biome-organize-imports",
    }
  end,

  prettier = function(bufnr)
    return {
      first(bufnr, "prettierd", "prettier"),
    }
  end,

  eslint = function(bufnr)
    return {
      first(bufnr, "eslint_d", "eslint"),
    }
  end,

  stylelint = function()
    return {
      "stylelint",
    }
  end,
}

return {
  typescript = function(bufnr)
    local project_root = vim.fs.root(0, "package.json") or require("utils.git").get_workspace_root()

    local package_json = vim.fs.joinpath(project_root, "package.json")
    if vim.fn.filereadable(package_json) == 1 then
      local package = vim.fn.json_decode(vim.fn.readfile(package_json))
      local deps = (package and package.devDependencies) or {}

      if deps["@biomejs/biome"] then
        return formatters.biome()
      elseif deps["prettier"] then
        return formatters.prettier(bufnr)
      end
    end

    return formatters.eslint(bufnr)
  end,

  css = function(bufnr)
    local sources = {}

    local project_root = vim.fs.root(0, "package.json") or require("utils.git").get_workspace_root()

    local package_json = vim.fs.joinpath(project_root, "package.json")
    if vim.fn.filereadable(package_json) == 1 then
      local package = vim.fn.json_decode(vim.fn.readfile(package_json))
      local deps = (package and package.devDependencies) or {}

      if deps["stylelint"] then
        vim.list_extend(sources, formatters.stylelint())
      end

      if deps["@biomejs/biome"] then
        vim.list_extend(sources, formatters.biome())
      elseif deps["prettier"] then
        vim.list_extend(sources, formatters.prettier(bufnr))
      end
    end

    return sources
  end,
}
