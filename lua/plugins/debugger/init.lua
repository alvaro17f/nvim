-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation

if Flags.debugger == false then
  return {}
end

Pack.add({
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/jbyuki/one-small-step-for-vimkind",
  "https://github.com/theHamsta/nvim-dap-virtual-text",
  "https://github.com/miroshQa/debugmaster.nvim",
  "https://github.com/mfussenegger/nvim-dap",
})

local dm = require("debugmaster")
local virtual_text = require("nvim-dap-virtual-text")

Utils.debugger.debugger_icons()
virtual_text.setup({})

dm.plugins.osv_integration.enabled = true

Utils.require_modules("plugins/debugger")

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
