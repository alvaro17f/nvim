_G.Utils = _G.Utils or {}
_G.Utils.snacks = _G.Utils.snacks or {}
_G.Utils.snacks.picker = _G.Utils.snacks.picker or {}

Utils.snacks.picker.status = {
  is_grep = nil,
  is_git = nil,
}

---@param picker table
Utils.snacks.picker.switch_grep_files = function(picker)
  local cwd = picker.input.filter.cwd

  picker:close()

  vim.schedule(function()
    if Utils.snacks.picker.status.is_grep then
      local pattern = picker.input.filter.search or picker.input.filter.pattern
      if Utils.snacks.picker.status.is_git then
        Snacks.picker.git_files({ cwd = cwd, pattern = pattern })
      else
        Snacks.picker.files({ cwd = cwd, pattern = pattern })
      end
      Utils.snacks.picker.status = {
        is_grep = false,
        is_git = Utils.snacks.picker.status.is_git,
      }
      return
    else
      local pattern = picker.input.filter.pattern or picker.input.filter.search
      Snacks.picker.grep({ cwd = cwd, search = pattern })
      Utils.snacks.picker.status = {
        is_grep = true,
        is_git = Utils.snacks.picker.status.is_git,
      }
    end
  end)
end
