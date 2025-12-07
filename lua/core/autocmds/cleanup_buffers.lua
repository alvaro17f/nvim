local BUFFERS_LIMIT = 10

vim.api.nvim_create_autocmd("BufAdd", {
  callback = function()
    local bufs = vim.fn.getbufinfo({ buflisted = 1 })
    if #bufs > BUFFERS_LIMIT then
      for _, buf in ipairs(bufs) do
        if buf.bufnr ~= vim.api.nvim_get_current_buf() and buf.changed == 0 then
          vim.cmd("bdelete " .. buf.bufnr)
          break
        end
      end
    end
  end,
})
