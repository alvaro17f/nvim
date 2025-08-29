-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation

if vim.g.debugger == false then
  return {}
end

vim.pack.add({
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/jbyuki/one-small-step-for-vimkind",
  "https://github.com/theHamsta/nvim-dap-virtual-text",
  "https://github.com/miroshQa/debugmaster.nvim",
  "https://github.com/mfussenegger/nvim-dap",
}, { load = true, confirm = false })

local dm = require("debugmaster")
local utils = require("utils")
local utils_debugger = require("utils.debugger")
local virtual_text = require("nvim-dap-virtual-text")

utils_debugger.debugger_icons()
virtual_text.setup({})

dm.plugins.osv_integration.enabled = true

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
vim.keymap.set({ "n", "v" }, "<leader>d", dm.mode.toggle, { nowait = true })
vim.keymap.set("t", "<C-\\>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
