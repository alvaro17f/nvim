local timers = {}
local DELAY = 500

local should_save = function(bufnr)
  local bo = vim.bo[bufnr]
  return vim.g.autosave and bo.modifiable and bo.buflisted and bo.buftype == "" and bo.modified
end

local save = function(bufnr)
  if not vim.api.nvim_buf_is_valid(bufnr) or vim.api.nvim_buf_get_name(bufnr) == "" then
    return
  end

  local current = vim.api.nvim_get_current_buf()
  if current == bufnr then
    vim.cmd("silent! write")
  else
    local success, error = pcall(function()
      vim.cmd("silent! write! " .. vim.api.nvim_buf_get_name(bufnr))
    end)

    if not success then
      print("󰄳 auto-save: failed to save - " .. error)
      return
    end
  end

  print("󰄳 auto-save: saved at " .. vim.fn.strftime("%H:%M:%S"))
end

local cleanup = function(bufnr)
  local timer = timers[bufnr]
  if timer then
    timer:stop()
    timer:close()
    timers[bufnr] = nil
  end
end

vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, {
  callback = function(args)
    local bufnr = args.buf
    if not should_save(bufnr) then
      return
    end

    cleanup(bufnr)

    local timer = vim.uv.new_timer()
    if not timer then
      return
    end

    timers[bufnr] = timer
    timer:start(DELAY, 0, function()
      vim.schedule(function()
        if vim.api.nvim_buf_is_valid(bufnr) and vim.bo[bufnr].modified then
          save(bufnr)
        end
        cleanup(bufnr)
      end)
    end)
  end,
})

vim.api.nvim_create_autocmd("InsertEnter", {
  callback = function(args)
    cleanup(args.buf)
  end,
})

vim.api.nvim_create_autocmd("BufLeave", {
  callback = function(args)
    local bufnr = args.buf
    if timers[bufnr] and should_save(bufnr) then
      save(bufnr)
    end
    cleanup(bufnr)
  end,
})

vim.api.nvim_create_autocmd("BufUnload", {
  callback = function(args)
    cleanup(args.buf)
  end,
})

vim.api.nvim_create_autocmd("VimLeave", {
  callback = function()
    for _, timer in pairs(timers) do
      timer:stop()
      timer:close()
    end
    timers = {}
  end,
})
