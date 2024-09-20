local term = nil
local is_git_repo = require("utils.git").is_git_repo

local function lazygit_toggle()
  local Terminal = require("toggleterm.terminal").Terminal

  local size = 90
  local direction = "float"

  if not term then
    term = Terminal:new({
      cmd = "lazygit",
      hidden = true,
      count = 0,
      on_exit = function()
        term = nil
      end,
    })
    if term then
      term:toggle(size, direction)

      vim.cmd("set ft=lazygit")
    end
  else
    term:toggle(size, direction)
  end
end

vim.keymap.set("n", "<leader>gg", function()
  if is_git_repo() then
    lazygit_toggle()
  end
end, {
  silent = true,
  desc = "Lazygit",
})
