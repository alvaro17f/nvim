local current_session = nil
local sessions_directory = vim.fn.stdpath("data") .. "/sessions/"

return {
  "echasnovski/mini.sessions",
  event = { "VeryLazy" },
  version = false,
  keys = {
    {
      "<leader>wl",
      function()
        require("utils.mini.sessions").select_session()
      end,
      desc = "Load session",
    },
    {
      "<leader>ws",
      function()
        require("utils.mini.sessions").new_session()
      end,
      desc = "Save session",
    },
    {
      "<leader>w<backspace>",
      function()
        require("utils.mini.sessions").restore_session()
      end,
      desc = "Load last session",
    },
    {
      "<leader>ww",
      function()
        if current_session then
          vim.notify("Current session: " .. current_session, vim.log.levels.INFO)
        else
          vim.notify("No current session", vim.log.levels.WARN)
        end
      end,
      desc = "Current session",
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
  },
}
