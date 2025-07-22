local M = {}

local formatters = {
  biome = {
    "biome-organize-imports",
    "biome-check",
    "biome",
    stop_after_first = false,
  },
  prettier = {
    "prettierd",
    "prettier",
    stop_after_first = true,
  },
  eslint = {
    "eslint_d",
    "eslint",
    stop_after_first = true,
  },
  stylelint = {
    "stylelint",
    stop_after_first = true,
  },
}

function M.typescript()
  local project_dir = vim.fs.root(0, "package.json") or require("utils.git").get_git_root()

  local package_json = vim.fs.joinpath(project_dir, "package.json")
  if vim.fn.filereadable(package_json) == 1 then
    local package = vim.fn.json_decode(vim.fn.readfile(package_json))
    local deps = (package and package.devDependencies) or {}

    if deps["@biomejs/biome"] then
      return formatters.biome
    elseif deps["prettier"] then
      return formatters.prettier
    end
  end

  return formatters.eslint
end

function M.css()
  local project_dir = vim.fs.root(0, "package.json") or require("utils.git").get_git_root()

  local package_json = vim.fs.joinpath(project_dir, "package.json")
  if vim.fn.filereadable(package_json) == 1 then
    local package = vim.fn.json_decode(vim.fn.readfile(package_json))
    local deps = (package and package.devDependencies) or {}

    if deps["stylelint"] then
      return formatters.stylelint
    elseif deps["biome"] then
      return formatters.biome
    elseif deps["prettier"] then
      return formatters.prettier
    end
  end

  return {}
end


return M
