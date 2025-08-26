vim.pack.add({ "https://github.com/okuuva/auto-save.nvim" }, { load = true, confirm = false })

local EXCLUDED_FILETYPES = {
  "grug-far",
  "lazy",
  "lazydo",
  "lazygit",
  "mason",
  "minifiles",
  "snacks_dashboard",
  "snacks_terminal",
  "snacks_picker_input",
  "yazi",
}

local setup_autosave_autocmds = function()
  vim.api.nvim_create_autocmd("User", {
    pattern = "AutoSaveEnable",
    callback = function(_)
      vim.notify("AutoSave enabled", vim.log.levels.INFO)
    end,
  })

  vim.api.nvim_create_autocmd("User", {
    pattern = "AutoSaveDisable",
    callback = function(_)
      vim.notify("AutoSave disabled", vim.log.levels.INFO)
    end,
  })
end

require("auto-save").setup({
  enabled = true, -- start auto-save when the plugin is loaded (i.e. when your package manager loads it)
  trigger_events = { -- See :h events
    immediate_save = { "BufLeave", "FocusLost" }, -- vim events that trigger an immediate save
    defer_save = { "InsertLeave", "TextChanged" }, -- vim events that trigger a deferred save (saves after `debounce_delay`)
    cancel_deferred_save = { "InsertEnter" }, -- vim events that cancel a pending deferred save
  },
  condition = function(buf)
    local bufVar = function(type)
      return vim.fn.getbufvar(buf, type)
    end

    -- don't save for special-buffers
    if bufVar("&buftype") ~= "" then
      return false
    end

    -- don't save for EXCLUDED_FILETYPES
    if vim.list_contains(EXCLUDED_FILETYPES, bufVar("&filetype")) then
      return false
    end

    return true
  end,
  write_all_buffers = false, -- write all buffers when the current one meets `condition`
  noautocmd = false, -- do not execute autocmds when saving
  lockmarks = false, -- lock marks when saving, see `:h lockmarks` for more details
  debounce_delay = 1000, -- delay after which a pending save is executed
  -- log debug messages to 'auto-save.log' file in neovim cache directory, set to `true` to enable
  debug = false,

  vim.api.nvim_create_autocmd("VimEnter", {
    callback = setup_autosave_autocmds,
  }),

  vim.api.nvim_create_autocmd("User", {
    pattern = "AutoSaveWritePost",
    callback = function(opts)
      if opts.data.saved_buffer ~= nil then
        print("󰄳 auto-save: saved at " .. vim.fn.strftime("%H:%M:%S"))
      end
    end,
  }),
})

vim.keymap.set("n", "<leader>*", "<CMD>ASToggle<CR>", { desc = "Toggle auto-save" })
