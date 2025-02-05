local M = {}

local snacks = require("snacks")

M.status = {
  is_grep = nil,
  is_git = nil,
}

function M.switch_grep_files(picker, _)
  local cwd = picker.input.filter.cwd

  picker:close()

  vim.schedule(function()
    if M.status.is_grep then
      local pattern = picker.input.filter.search or picker.input.filter.pattern
      if M.status.is_git then
        snacks.picker.git_files({ cwd = cwd, pattern = pattern })
      else
        snacks.picker.files({ cwd = cwd, pattern = pattern })
      end
      M.status = {
        is_grep = false,
        is_git = M.status.is_git,
      }
      return
    else
      local pattern = picker.input.filter.pattern or picker.input.filter.search
      snacks.picker.grep({ cwd = cwd, search = pattern })
      M.status = {
        is_grep = true,
        is_git = M.status.is_git,
      }
    end
  end)
end

return M
