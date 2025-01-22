---@diagnostic disable: duplicate-set-field
-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation

if vim.g.debugger == false then
  return {}
end

return {
  "mfussenegger/nvim-dap",
  dependencies = {
    { "nvim-lua/plenary.nvim" },
    { "rcarriga/nvim-dap-ui" },
    { "nvim-neotest/nvim-nio" },
    { "theHamsta/nvim-dap-virtual-text", opts = {} },
  },
  import = "plugins.debugger",
  --stylua: ignore
  keys = {
    {mode = "n", "<Leader>db", function() require("dap").toggle_breakpoint() end, desc = "Debugger: breakpoint" },
    {mode = "n", "<Leader>dc", function() require("dap").continue() end, desc = "Debugger: run/continue" },
    {mode = "n", "<leader>di", function() require("dap").step_into() end, desc = "Debugger: step into" },
    {mode = "n", "<leader>dj", function() require("dap").down() end, desc = "Debugger: down" },
    {mode = "n", "<leader>dk", function() require("dap").up() end, desc = "Debugger: up" },
    {mode = "n", "<leader>dl", function() require("dap").run_last() end, desc = "Debugger: run last" },
    {mode = "n", "<leader>do", function() require("dap").step_out() end, desc = "Debugger: step out" },
    {mode = "n", "<leader>dO", function() require("dap").step_over() end, desc = "Debugger: step over" },
    {mode = "n", "<leader>dP", function() require("dap").pause() end, desc = "Debugger: pause" },
    {mode = "n", "<Leader>dr", function() require("dap").repl.toggle({ height = 15 }) end, desc = "Debugger: REPL toggle" },
    {mode = "n", "<Leader>du", function() require("dapui").toggle() end, desc = "Debugger: UI toggle" },
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    require("utils.debugger").debugger_icons()

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

    ----------------------------
    -- vscode launch.json file
    ----------------------------
    local vscode = require("dap.ext.vscode")
    local json = require("plenary.json")
    vscode.json_decode = function(str)
      return vim.json.decode(json.json_strip_comments(str))
    end
    ----------------------------
  end,
}
