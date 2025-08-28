vim.pack.add({ "https://github.com/nvim-mini/mini.icons" }, { load = true, confirm = false })

package.preload["nvim-web-devicons"] = function()
  require("mini.icons").mock_nvim_web_devicons()
  return package.loaded["nvim-web-devicons"]
end
