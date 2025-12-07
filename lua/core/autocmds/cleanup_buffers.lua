vim.api.nvim_create_autocmd("BufAdd", {
  callback = function()
    local bufs = vim.fn.getbufinfo({ buflisted = 1 })
    if #bufs > 10 then
      for _, buf in ipairs(bufs) do
        if buf.bufnr ~= vim.api.nvim_get_current_buf() then
          vim.cmd("bdelete " .. buf.bufnr)
          break
        end
      end
    end
  end,
})
