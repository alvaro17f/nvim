Pack.add({ "https://github.com/nvim-mini/mini.icons" })

local MiniIcons = require("mini.icons")

package.preload["nvim-web-devicons"] = function()
  MiniIcons.mock_nvim_web_devicons()
  return package.loaded["nvim-web-devicons"]
end
