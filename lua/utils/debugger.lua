local M = {}

M.DEBUGGERS = {
  "codelldb",
  "delve",
  "js-debug-adapter",
}

function M.debugger_executable_path(debugger_name)
  return vim.fn.stdpath("data") .. "/mason/bin/" .. debugger_name
end

function M.find_debug_target(targetPrefix, depth, buildCommand)
  local dap = require("dap")
  local targets = {}
  for entry in vim.fs.dir(targetPrefix, { depth = depth }) do
    if vim.fn.executable(targetPrefix .. entry) == 1 then
      table.insert(targets, entry)
    end
  end
  if #targets == 1 then
    return targetPrefix .. targets[1]
  end
  if #targets == 0 then
    return vim.fn.system(buildCommand) -- return vim.fn.input("Path to executable: ", get_workspace_root() .. "/", "file")
  end
  return coroutine.create(function(coro)
    vim.ui.select(targets, {
      prompt = "Select target to debug: ",
    }, function(choice)
      if choice == nil then
        coroutine.resume(coro, dap.ABORT)
      else
        coroutine.resume(coro, targetPrefix .. choice)
      end
    end)
  end)
end

return M
