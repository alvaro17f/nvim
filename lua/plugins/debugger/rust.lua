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

dap.configurations.rust = {
  {
    type = "codelldb",
    name = "Debug",
    request = "launch",
    program = Utils.debugger.find_debug_target(
      Utils.git.get_workspace_root() .. "/target/release/",
      2,
      { "cargo", "build", "--release" }
    ),
    cwd = Utils.git.get_workspace_root,
    stopOnEntry = false,
  },
}
