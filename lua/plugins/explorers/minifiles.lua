Pack.add({ "https://github.com/echasnovski/mini.files" })

local MiniFiles = require("mini.files")

MiniFiles.setup({
  content = {
    filter = nil,
    prefix = nil,
    sort = nil,
  },

  mappings = {
    close = "q",
    go_in = "L",
    go_in_plus = "l",
    go_out = "H",
    go_out_plus = "h",
    mark_goto = "'",
    mark_set = "m",
    reset = "<BS>",
    reveal_cwd = "@",
    show_help = "g?",
    synchronize = "=",
    trim_left = ">",
    trim_right = "<",
  },

  options = {
    permanent_delete = false,
    use_as_default_explorer = true,
  },

  windows = {
    max_number = math.huge,
    preview = true,
    width_focus = 50,
    width_nofocus = 15,
    width_preview = 50,
  },
})

local set_mark = function(id, path, desc)
  MiniFiles.set_bookmark(id, path, { desc = desc })
end

vim.api.nvim_create_autocmd("User", {
  pattern = { "MiniFilesExplorerOpen" },
  callback = function()
    set_mark("'", vim.fn.getcwd, "Working directory")
    set_mark("n", vim.fn.stdpath("config"), "Nvim config")
    set_mark("c", "~/.config", "Config directory")
    set_mark("d", "~/Downloads", "Downloads directory")
    set_mark("h", "~", "Home directory")
    set_mark("l", "~/.local", "Local directory")
    set_mark("w", "~/Workspace", "Workspace directory")
    set_mark("x", "~/Documents", "Documents directory")
  end,
})

vim.api.nvim_create_autocmd("User", {
  pattern = "MiniFilesWindowUpdate",
  callback = function(ev)
    -- Window width based on the offset from the center, i.e. center window
    -- is 60, then next over is 20, then the rest are 10.
    -- Can use more resolution if you want like { 60, 20, 20, 10, 5 }
    local widths = { 60, 20, 10 }

    local state = MiniFiles.get_explorer_state()
    if state == nil then
      return
    end

    -- Compute "depth offset" - how many windows are between this and focused
    local path_this = vim.api.nvim_buf_get_name(ev.data.buf_id):match("^minifiles://%d+/(.*)$")
    local depth_this
    for i, path in ipairs(state.branch) do
      if path == path_this then
        depth_this = i
      end
    end
    if depth_this == nil then
      return
    end
    local depth_offset = depth_this - state.depth_focus

    -- Adjust config of this event's window
    local i = math.abs(depth_offset) + 1
    local win_config = vim.api.nvim_win_get_config(ev.data.win_id)
    win_config.width = i <= #widths and widths[i] or widths[#widths]

    win_config.col = math.floor(0.5 * (vim.o.columns - widths[1]))
    for j = 1, math.abs(depth_offset) do
      local sign = depth_offset == 0 and 0 or (depth_offset > 0 and 1 or -1)
      -- widths[j+1] for the negative case because we don't want to add the center window's width
      local prev_win_width = (sign == -1 and widths[j + 1]) or widths[j] or widths[#widths]
      -- Add an extra +2 each step to account for the border width
      win_config.col = win_config.col + sign * (prev_win_width + 2)
    end

    win_config.height = depth_offset == 0 and 25 or 20
    win_config.row = math.floor(0.5 * (vim.o.lines - win_config.height))
    win_config.border = { "🭽", "▔", "🭾", "▕", "🭿", "▁", "🭼", "▏" }
    vim.api.nvim_win_set_config(ev.data.win_id, win_config)
  end,
})

vim.keymap.set("n", "<leader>/", "<CMD>lua MiniFiles.open()<CR>", { desc = "MiniFiles" })
