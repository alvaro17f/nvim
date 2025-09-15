local dap = require("dap")

dap.adapters.codelldb = {
  type = "server",
  port = "${port}",
  executable = {
    command = Utils.debugger.debugger_executable_path("codelldb"),
    args = { "--port", "${port}" },
    detached = vim.fn.has("win32") == 0,
  },
}

dap.configurations.c = {
  {
    type = "codelldb",
    name = "Debug",
    request = "launch",
    program = "${file}",
    cwd = Utils.git.get_workspace_root,
    stopOnEntry = false,
  },
}
