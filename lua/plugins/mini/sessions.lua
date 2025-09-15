Pack.add({ "https://github.com/nvim-mini/mini.sessions" })

local current_session = nil
local sessions_directory = vim.fn.stdpath("data") .. "/sessions/"

local MiniSessions = require("mini.sessions")
local utils = require("plugins.mini.utils.sessions")

local edgy = function()
  if Utils.require_safe("edgy") then
    require("edgy").close()
  end
end

local arrow = function()
  if Utils.require_safe("arrow") then
    require("arrow.git").refresh_git_branch()
    require("arrow.persist").load_cache_file()
  end
end

MiniSessions.setup({
  autoread = false,
  autowrite = true,
  directory = sessions_directory,
  file = "", -- File for local session (use `''` to disable)
  force = { read = false, write = true, delete = true },
  hooks = {
    pre = {
      read = nil,
      write = function()
        edgy()
      end,
      delete = nil,
    },
    post = {
      read = function(item)
        current_session = item.name
        arrow()
      end,
      write = nil,
      delete = nil,
    },
  },
  verbose = { read = false, write = true, delete = true },

  vim.api.nvim_create_autocmd("VimLeavePre", {
    callback = function()
      if utils.has_valid_buffers() and not current_session then
        local session = require("mini.sessions")
        session.write("draft")
      end
    end,
  }),
})

vim.keymap.set("n", "<leader>wl", function()
  utils.select_session()
end, { desc = "Load Session" })

vim.keymap.set("n", "<leader>ws", function()
  utils.new_session(true)
end, { desc = "Save Session" })

vim.keymap.set("n", "<leader>w<backspace>", function()
  utils.restore_session()
end, { desc = "Restore Last Session" })

vim.keymap.set("n", "<leader>ww", function()
  if current_session then
    vim.notify("Current session: " .. current_session, vim.log.levels.INFO)
  else
    vim.notify("No current session", vim.log.levels.WARN)
  end
end, { desc = "Show Current Session" })
