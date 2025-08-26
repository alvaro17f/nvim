vim.pack.add({ "https://github.com/echasnovski/mini.sessions" }, { load = true, confirm = false })

local current_session = nil
local sessions_directory = vim.fn.stdpath("data") .. "/sessions/"
local require_safe = require("utils").require_safe

require("mini.sessions").setup({
  autoread = false,
  autowrite = true,
  directory = sessions_directory,
  file = "", -- File for local session (use `''` to disable)
  force = { read = false, write = true, delete = true },
  hooks = {
    pre = {
      read = nil,
      write = function()
        local edgy = require_safe("edgy")
        local diffview = require_safe("diffview.lib")
        local dap = require_safe("dap")
        local dapui = require_safe("dapui")

        if edgy then
          edgy.close()
        end

        if diffview and diffview.get_current_view() then
          vim.cmd.DiffviewClose()
        end

        if dap and dap.session() ~= nil then
          if dapui then
            dapui.close()
          end
        end
      end,
      delete = nil,
    },
    post = {
      read = function(item)
        current_session = item.name
      end,
      write = nil,
      delete = nil,
    },
  },
  verbose = { read = false, write = true, delete = true },

  vim.api.nvim_create_autocmd("VimLeavePre", {
    callback = function()
      if require("utils.mini.sessions").has_valid_buffers() and not current_session then
        local session = require("mini.sessions")
        session.write("draft.vim")
      end
    end,
  }),
})

vim.keymap.set("n", "<leader>wl", function()
  require("utils.mini.sessions").select_session()
end, { desc = "Load Session" })

vim.keymap.set("n", "<leader>ws", function()
  require("utils.mini.sessions").new_session(true)
end, { desc = "Save Session" })

vim.keymap.set("n", "<leader>w<backspace>", function()
  require("utils.mini.sessions").restore_session()
end, { desc = "Restore Last Session" })

vim.keymap.set("n", "<leader>ww", function()
  if current_session then
    vim.notify("Current session: " .. current_session, vim.log.levels.INFO)
  else
    vim.notify("No current session", vim.log.levels.WARN)
  end
end, { desc = "Show Current Session" })
