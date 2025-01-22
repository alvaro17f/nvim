local current_session = false
local sessions_directory = vim.fn.stdpath("data") .. "/sessions/"

local function has_valid_buffers()
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    local buflisted = vim.bo[bufnr].buflisted
    local readonly = vim.bo[bufnr].readonly
    local bufname = vim.api.nvim_buf_get_name(bufnr)

    if buflisted and not readonly then
      if bufname ~= "" then
        return true
      end
      local line_count = vim.api.nvim_buf_line_count(bufnr)
      if line_count > 1 or (line_count == 1 and vim.api.nvim_buf_get_lines(bufnr, 0, 1, false)[1] ~= "") then
        return true
      end
    end
  end
  return false
end

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
        if has_valid_buffers() and not current_session then
          local session = require("mini.sessions")
          session.write("draft.vim")
        end
      end,
    }),
  },
}
