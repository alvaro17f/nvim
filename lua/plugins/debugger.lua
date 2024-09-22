-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
if require("utils.flags").get_flags("debugger") == false then
  return {}
end

return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
  },
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
    vim.fn.sign_define("DapStopped", { text = "▶️" })

    dap.adapters = require("utils.debugger").ADAPTERS

    dap.configurations = require("utils.debugger").CONFIGURATIONS

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
