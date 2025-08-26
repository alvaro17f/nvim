---@diagnostic disable: assign-type-mismatch

local M = {}

function M.debugger_icons()
  vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

  local dap_icons = {
    Stopped = { "󰁕 ", "DiagnosticWarn", "DapStoppedLine" },
    Breakpoint = " ",
    BreakpointCondition = " ",
    BreakpointRejected = { " ", "DiagnosticError" },
    LogPoint = ".>",
  }

  for name, sign in pairs(dap_icons) do
    sign = type(sign) == "table" and sign or { sign }
    vim.fn.sign_define(
      "Dap" .. name,
      { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
    )
  end
end

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
