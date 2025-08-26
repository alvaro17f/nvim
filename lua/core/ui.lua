------------------------------------
-- UI
------------------------------------
local ui = require("vim._extui")

ui.enable({
  enable = true,
  msg = {
    target = "msg",
    timeout = 1200,
  },
})

------------------------------------
-- WINBAR
------------------------------------
vim.api.nvim_create_autocmd("WinResized", {
  callback = function(args)
    if
      not vim.api.nvim_win_get_config(0).zindex -- Not a floating window
      and vim.bo[args.buf].buftype == "" -- Normal buffer
      and vim.api.nvim_buf_get_name(args.buf) ~= "" -- Has a file name
      and not vim.wo[0].diff -- Not in diff mode then
    then
      vim.o.winbar = "%=" .. "%{%v:lua.require('utils.winbar').winbar_get_icon()%}" .. "  " .. "%f" .. " " .. "%m"
    else
      vim.o.winbar = nil
    end
  end,
})
