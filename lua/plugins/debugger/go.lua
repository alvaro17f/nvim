return {
  "nvim-dap",
  opts = function()
    local dap = require("dap")
    local debugger_utils = require("utils.debugger")
    local git = require("utils.git")

    dap.adapters.delve = {
      type = "server",
      port = "${port}",
      executable = {
        command = debugger_utils.debugger_executable_path("dlv"),
        args = { "dap", "-l", "127.0.0.1:${port}" },
        detached = vim.fn.has("win32") == 0,
      },
    }

    dap.configurations.go = {
      {
        type = "delve",
        name = "Debug",
        request = "launch",
        program = debugger_utils.find_debug_target(
          git.get_workspace_root() .. "/bin/",
          2,
          { "go", "build", "-o", "./bin/" }
        ),
        cwd = git.get_workspace_root,
        stopOnEntry = false,
      },
      {
        type = "delve",
        name = "Debug test",
        request = "launch",
        mode = "test",
        program = "${file}",
      },
      {
        type = "delve",
        name = "Debug test (go.mod)",
        request = "launch",
        mode = "test",
        program = "./${relativeFileDirname}",
      },
    }
  end,
}
