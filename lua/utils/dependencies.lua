local DEPENDENCIES = {
  { name = "lazygit", function_name = "lazygit" },
  { name = "fzf" },
  { name = "rg" },
  { name = "fd" },
}

local dependencies_group = vim.api.nvim_create_augroup("Dependencies", { clear = true })

local function handle_dependencies_check(executable, func_name)
  return function()
    if vim.fn.executable(executable) == 1 then
      if func_name then
        require("utils." .. func_name)
      end
    else
      vim.notify(" missing: '" .. executable .. "'", vim.log.levels.WARN)
    end
  end
end

return function()
  for _, exec in ipairs(DEPENDENCIES) do
    vim.api.nvim_create_autocmd({ "VimEnter" }, {
      group = dependencies_group,
      pattern = "*",
      callback = handle_dependencies_check(exec.name, exec.function_name),
    })
  end
end