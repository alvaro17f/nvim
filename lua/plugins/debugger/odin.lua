local dap = require("dap")
local debugger_utils = require("utils.debugger")
local git = require("utils.git")

dap.adapters.codelldb = {
  type = "server",
  port = "${port}",
  executable = {
    command = debugger_utils.debugger_executable_path("codelldb"),
    args = { "--port", "${port}" },
    detached = vim.fn.has("win32") == 0,
  },
}

dap.configurations.odin = {
  {
    type = "codelldb",
    name = "Debug",
    request = "launch",
    program = debugger_utils.find_debug_target(git.get_workspace_root() .. "/", 2, { "odin", "build", ".", "-debug" }),
    cwd = git.get_workspace_root,
    stopOnEntry = false,
  },
}
