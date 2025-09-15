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

dap.configurations.zig = {
  {
    type = "codelldb",
    name = "Debug",
    request = "launch",
    program = Utils.debugger.find_debug_target(
      Utils.git.get_workspace_root() .. "/zig-out/bin/",
      2,
      { "zig", "build", "-Doptimize=Debug" }
    ),
    cwd = Utils.git.get_workspace_root,
    stopOnEntry = false,
  },
}
