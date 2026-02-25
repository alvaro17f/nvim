------------------------------------
-- UI
------------------------------------
local ui = require("vim._core.ui2")

ui.enable({
  enable = true,
  msg = {
    ---@type 'cmd'|'msg'
    target = "msg",
    timeout = 4000,
  },
})
