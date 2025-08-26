-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation

if vim.g.debugger == false then
  return {}
end

vim.pack.add({
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/rcarriga/nvim-dap-ui",
  "https://github.com/nvim-neotest/nvim-nio",
  "https://github.com/theHamsta/nvim-dap-virtual-text",
  "https://github.com/mfussenegger/nvim-dap",
}, { load = true, confirm = false })

local dap = require("dap")
local dapui = require("dapui")

require("utils.debugger").debugger_icons()

require("nvim-dap-virtual-text").setup()

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

local utils = require("utils")

local path = vim.fn.stdpath("config") .. "/lua/plugins/debugger/"

utils.require_modules(path)

----------------------------
-- vscode launch.json file
----------------------------
local json = require("plenary.json")
local vscode = require("dap.ext.vscode")
vscode.json_decode = function(str)
  return vim.json.decode(json.json_strip_comments(str))
end
----------------------------

--stylua: ignore start
  vim.keymap.set("n", "<Leader>db", function() require("dap").toggle_breakpoint() end, { desc = "Debugger: breakpoint" })
  vim.keymap.set("n", "<Leader>dc", function() require("dap").continue() end, { desc = "Debugger: run/continue" })
  vim.keymap.set("n", "<leader>di", function() require("dap").step_into() end, { desc = "Debugger: step into" })
  vim.keymap.set("n", "<leader>dj", function() require("dap").down() end, { desc = "Debugger: down" })
  vim.keymap.set("n", "<leader>dk", function() require("dap").up() end, { desc = "Debugger: up" })
  vim.keymap.set("n", "<leader>dl", function() require("dap").run_last() end, { desc = "Debugger: run last" })
  vim.keymap.set("n", "<leader>do", function() require("dap").step_out() end, { desc = "Debugger: step out" })
  vim.keymap.set("n", "<leader>dO", function() require("dap").step_over() end, { desc = "Debugger: step over" })
  vim.keymap.set("n", "<leader>dP", function() require("dap").pause() end, { desc = "Debugger: pause" })
  vim.keymap.set("n", "<Leader>dr", function() require("dap").repl.toggle({ height = 15 }) end, { desc = "Debugger: REPL toggle" })
  vim.keymap.set("n", "<Leader>du", function() require("dapui").toggle() end, { desc = "Debugger: UI toggle" })
--stylua : ignore end
