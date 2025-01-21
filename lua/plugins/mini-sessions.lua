local current_session = false
local sessions_directory = vim.fn.stdpath("data") .. "/sessions/"

return {
  "echasnovski/mini.sessions",
  event = { "VeryLazy" },
  version = false,
  keys = {
    {
      "<leader>ww",
      function()
        local session = require("mini.sessions")
        session.select()
      end,
      desc = "Load session",
    },
    {
      "<leader>ws",
      function()
        local session = require("mini.sessions")
        local session_name = vim.fn.input("Session name: ")

        if session_name == "" then
          return vim.notify("Session save canceled", vim.log.levels.ERROR)
        end

        session.write(session_name .. ".vim")
      end,
      desc = "Save session",
    },
    {
      "<leader>wd",
      function()
        local sessions_dir = sessions_directory
        local sessions = vim.fn.globpath(sessions_dir, "*.vim", false, true)
        for i, session in ipairs(sessions) do
          sessions[i] = vim.fn.fnamemodify(session, ":t")
        end

        vim.ui.select(sessions, { prompt = "Select session to delete:" }, function(choice)
          if choice then
            local session = require("mini.sessions")
            session.delete(choice)
          end
        end)
      end,
      desc = "Delete session",
    },
    {
      "<leader>w<backspace>",
      function()
        local session = require("mini.sessions")
        session.read(session.get_latest())
      end,
      desc = "Load last session",
    },
  },
  opts = {
    autoread = false,
    autowrite = true,
    directory = sessions_directory,
    file = "", -- File for local session (use `''` to disable)
    force = { read = false, write = true, delete = true },
    hooks = {
      pre = {
        read = nil,
        write = function()
          local edgy, diffview, dap, dapui = require("edgy"), require("diffview.lib"), require("dap"), require("dapui")

          edgy.close()

          if diffview.get_current_view() then
            vim.cmd.DiffviewClose()
          end

          if vim.g.debugger and dap.session() ~= nil then
            dapui.close()
          end
        end,
        delete = nil,
      },
      post = {
        read = function()
          current_session = true
        end,
        write = nil,
        delete = nil,
      },
    },
    verbose = { read = false, write = true, delete = true },

    vim.api.nvim_create_autocmd("VimLeavePre", {
      callback = function()
        local buffers = vim.api.nvim_list_bufs()
        if #buffers == 1 then
          local buftype = vim.bo[buffers[1]].buftype
          local filename = vim.fn.expand("%:t")
          if buftype == "" or filename:match("^tmp") then
            return
          end
        end

        if not current_session then
          local session = require("mini.sessions")
          session.write("draft.vim")
        end
      end,
    }),
  },
}
