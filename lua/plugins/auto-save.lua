local EXCLUDED_FILETYPES = {
  "alpha",
  "lazy",
  "mason",
  "oil",
  "TelescopePrompt",
}

return {
  "okuuva/auto-save.nvim",
  lazy = false,
  keys = {
    { mode = "n", "<leader>*", ":ASToggle<CR>", desc = "Toggle auto-save" },
  },
  opts = {
    enabled = true, -- start auto-save when the plugin is loaded (i.e. when your package manager loads it)
    execution_message = {
      enabled = true,
      message = function() -- message to print on save
        return ("󰄳 auto-save: saved at " .. vim.fn.strftime("%H:%M:%S"))
      end,
      dim = 0.18, -- dim the color of `message`
      cleaning_interval = 1250, -- (milliseconds) automatically clean MsgArea after displaying `message`. See :h MsgArea
    },
    trigger_events = { -- See :h events
      immediate_save = { "BufLeave", "FocusLost" }, -- vim events that trigger an immediate save
      defer_save = { "InsertLeave", "TextChanged" }, -- vim events that trigger a deferred save (saves after `debounce_delay`)
      cancel_defered_save = { "InsertEnter" }, -- vim events that cancel a pending deferred save
    },
    condition = function(buf)
      local fn = vim.fn
      local utils = require("auto-save.utils.data")

      -- don't save for special-buffers
      if fn.getbufvar(buf, "&buftype") ~= "" then
        return false
      end

      -- don't save for EXCLUDED_FILETYPES
      if utils.not_in(fn.getbufvar(buf, "&filetype"), EXCLUDED_FILETYPES) then
        return true
      end
      return false
    end,
    write_all_buffers = false, -- write all buffers when the current one meets `condition`
    noautocmd = false, -- do not execute autocmds when saving
    lockmarks = false, -- lock marks when saving, see `:h lockmarks` for more details
    debounce_delay = 1000, -- delay after which a pending save is executed
    -- log debug messages to 'auto-save.log' file in neovim cache directory, set to `true` to enable
    debug = false,
  },
}
