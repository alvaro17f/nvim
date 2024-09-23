local M = {}

local function debugger_executable_path(debugger_name)
  return vim.fn.stdpath("data") .. "/mason/bin/" .. debugger_name
end

local function debugger_config_maker(debugger, additional_configs)
  local base_config = {
    {
      type = debugger,
      name = "Debug",
      request = "launch",
      program = "${file}",
      cwd = "${workspaceFolder}",
      stopOnEntry = false,
    },
  }

  if additional_configs then
    for _, config in ipairs(additional_configs) do
      config.type = debugger
      table.insert(base_config, config)
    end
  end

  return base_config
end

M.ADAPTERS = {
  delve = {
    type = "server",
    port = "${port}",
    executable = {
      command = debugger_executable_path("dlv"),
      args = { "dap", "-l", "127.0.0.1:${port}" },
      -- detached = false, -- windows only
    },
  },
  codelldb = {
    type = "server",
    port = "${port}",
    executable = {
      command = debugger_executable_path("codelldb"),
      args = { "--port", "${port}" },
      -- detached = false, -- windows only
    },
  },
}

M.DEBUGGERS = {}
for key, _ in pairs(M.ADAPTERS) do
  table.insert(M.DEBUGGERS, key)
end

M.CONFIGURATIONS = {
  c = debugger_config_maker("codelldb"),
  cpp = debugger_config_maker("codelldb"),
  go = debugger_config_maker("delve", {
    {
      name = "Debug test",
      request = "launch",
      mode = "test",
      program = "${file}",
    },
    {
      name = "Debug test (go.mod)",
      request = "launch",
      mode = "test",
      program = "./${relativeFileDirname}",
    },
  }),
  rust = debugger_config_maker("codelldb"),
  zig = debugger_config_maker("codelldb"),
}

return M
