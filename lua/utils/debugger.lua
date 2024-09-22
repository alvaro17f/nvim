local M = {}

local function debugger_executable_path(debugger_name)
  return vim.fn.stdpath("data") .. "/mason/bin/" .. debugger_name
end

M.DEBUGGERS = {
  "delve",
}

M.ADAPTERS = {
  delve = {
    type = "server",
    port = "${port}",
    executable = {
      command = debugger_executable_path("dlv"),
      args = { "dap", "-l", "127.0.0.1:${port}" },
      -- add this if on windows, otherwise server won't open successfully
      -- detached = false
    },
  },
}

M.CONFIGURATIONS = {
  go = {
    {
      type = "delve",
      name = "Debug",
      request = "launch",
      program = "${file}",
    },
    {
      type = "delve",
      name = "Debug test", -- configuration for debugging test files
      request = "launch",
      mode = "test",
      program = "${file}",
    },
    -- works with go.mod packages and sub packages
    {
      type = "delve",
      name = "Debug test (go.mod)",
      request = "launch",
      mode = "test",
      program = "./${relativeFileDirname}",
    },
  },
}

return M
