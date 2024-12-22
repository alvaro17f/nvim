return {
  "echasnovski/mini.icons",
  lazy = true,
  version = false,
  config = function()
    local mini_icons = require("mini.icons")
    mini_icons.setup()
    mini_icons.mock_nvim_web_devicons() -- mock nvim-web-devicons
  end,
}
