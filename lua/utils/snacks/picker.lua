local M = {}
M.is_grep = nil

function M.switch_grep_files(picker, _)
  local snacks = require("snacks")
  local cwd = picker.input.filter.cwd

  picker:close()

  if M.is_grep then
    local pattern = picker.input.filter.search or picker.input.filter.pattern
    snacks.picker.files({ cwd = cwd, pattern = pattern })
    M.is_grep = false
    return
  else
    local pattern = picker.input.filter.pattern or picker.input.filter.search
    snacks.picker.grep({ cwd = cwd, search = pattern })
    M.is_grep = true
  end
end

return M
