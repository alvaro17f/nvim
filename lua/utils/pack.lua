local M = {}

local pack_clean = function()
  local plugins = vim.pack.get()
  local unused_plugins = {}

  for _, plugin in ipairs(plugins) do
    if not plugin.active then
      table.insert(unused_plugins, plugin.spec.name)
    end
  end

  if #unused_plugins == 0 then
    return
  end

  local choice = vim.fn.confirm(
    "Remove " .. #unused_plugins .. " unused plugins?\n\n" .. table.concat(unused_plugins, "\n"),
    "&Yes\n&No",
    1
  )

  if choice == 1 then
    local success = pcall(vim.pack.del, unused_plugins)
    if success then
      vim.notify("Removed " .. #unused_plugins .. " plugins", vim.log.levels.INFO)
    else
      vim.notify("Failed to remove plugins", vim.log.levels.ERROR)
    end
  end
end

M.update = function()
  vim.pack.update(nil, { force = false })
  pack_clean()
end

return M
