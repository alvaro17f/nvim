local autosave_timer = nil
local DEBOUNCE_DELAY = 500

vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, {
  pattern = "*",
  callback = function(event)
    local bufnr = event.buf

    if
      vim.bo[bufnr].modifiable
      and vim.bo[bufnr].buflisted
      and vim.bo[bufnr].buftype == ""
      and vim.bo[bufnr].modified
    then
      if autosave_timer then
        vim.uv.timer_stop(autosave_timer)
      end

      autosave_timer = vim.uv.new_timer()

      if autosave_timer then
        vim.uv.timer_start(autosave_timer, DEBOUNCE_DELAY, 0, function()
          vim.schedule(function()
            if vim.api.nvim_buf_is_valid(bufnr) and vim.bo[bufnr].modified then
              vim.cmd("silent! write")
              print("󰄳 auto-save: saved at " .. vim.fn.strftime("%H:%M:%S"))
            end
            autosave_timer = nil
          end)
        end)
      end
    end
  end,
})

vim.api.nvim_create_autocmd("InsertEnter", {
  pattern = "*",
  callback = function()
    vim.schedule(function()
      if autosave_timer then
        vim.uv.timer_stop(autosave_timer)
        autosave_timer = nil
      end
    end)
  end,
})

vim.api.nvim_create_autocmd("BufUnload", {
  pattern = "*",
  callback = function(event)
    vim.schedule(function()
      if autosave_timer and vim.api.nvim_buf_is_valid(event.buf) and vim.api.nvim_get_current_buf() == event.buf then
        vim.uv.timer_stop(autosave_timer)
        autosave_timer = nil
      end
    end)
  end,
})
