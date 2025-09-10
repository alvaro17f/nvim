local timers = {}
local DELAY = 500

local function should_save(bufnr)
  local bo = vim.bo[bufnr]
  return bo.modifiable and bo.buflisted and bo.buftype == "" and bo.modified
end

local function save(bufnr)
  if not vim.api.nvim_buf_is_valid(bufnr) or vim.api.nvim_buf_get_name(bufnr) == "" then
    return
  end

  local current = vim.api.nvim_get_current_buf()
  vim.api.nvim_set_current_buf(bufnr)
  vim.cmd("silent! write")
  vim.api.nvim_set_current_buf(current)

  print("󰄳 auto-save: saved at " .. vim.fn.strftime("%H:%M:%S"))
end

local function cleanup(bufnr)
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
