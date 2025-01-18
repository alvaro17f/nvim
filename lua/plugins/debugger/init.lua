-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
if vim.g.debugger == false then
  return {}
end

return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
  },
  import = "plugins.debugger",
  keys = {
    {
      mode = "n",
      "<Leader>dt",
      function()
        require("dapui").toggle()
      end,
      desc = "Debugger UI toggle",
    },
    {
      mode = "n",
      "<Leader>db",
      function()
        require("dap").toggle_breakpoint()
      end,
      desc = "Debugger breakpoint",
    },
    {
      mode = "n",
      "<Leader>dc",
      function()
        require("dap").continue()
      end,
      desc = "Debugger continue",
    },
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    vim.fn.sign_define("DapBreakpoint", { text = "🐞" })
    vim.fn.sign_define("DapBreakpointCondition", { text = "ﳁ" })
    vim.fn.sign_define("DapBreakpointRejected", { text = "" })
    vim.fn.sign_define("DapLogPoint", { text = "" })
    vim.fn.sign_define("DapStopped", { text = "" })

    dapui.setup()

    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end
  end,
}
