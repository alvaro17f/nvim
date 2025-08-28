local M = {}

local function display_update_log()
  local log_file = vim.fn.expand(vim.fn.stdpath("log") .. "/nvim-pack.log")
  if vim.fn.filereadable(log_file) == 1 then
    local lines = vim.fn.readfile(log_file)
    local last_updates = {}
    local in_update_section = false

    for i = #lines, 1, -1 do
      local line = lines[i]
      if line:match("^========== Update") then
        if #last_updates > 0 then
          break
        else
          in_update_section = true
        end
      elseif in_update_section then
        table.insert(last_updates, 1, line)
      end
    end

    if #last_updates > 0 then
      local trimmed_updates = {}
      for _, line in ipairs(last_updates) do
        local trimmed = line:match("^%s*(.-)%s*$")
        if trimmed ~= "" then
          table.insert(trimmed_updates, line)
        end
      end

      if #trimmed_updates > 0 then
        local buf = vim.api.nvim_create_buf(false, true)
        vim.api.nvim_buf_set_lines(buf, 0, -1, false, trimmed_updates)

        vim.api.nvim_set_option_value("buftype", "nofile", { buf = buf })
        vim.api.nvim_set_option_value("bufhidden", "wipe", { buf = buf })
        vim.api.nvim_set_option_value("modifiable", false, { buf = buf })

        local win_config = {
          relative = "editor",
          width = math.min(120, vim.o.columns - 4),
          height = math.min(30, #trimmed_updates + 5),
          row = math.max(2, (vim.o.lines - math.min(30, #trimmed_updates + 5)) / 2),
          col = (vim.o.columns - math.min(120, vim.o.columns - 4)) / 2,
          style = "minimal",
          border = "rounded",
        }

        local win = vim.api.nvim_open_win(buf, true, win_config)
        vim.api.nvim_set_option_value("winblend", 0, { win = win })

        vim.api.nvim_buf_set_keymap(buf, "n", "q", "<cmd>close<CR>", {
          noremap = true,
          silent = true,
          nowait = true,
        })
      end
    end
  end
end

function M.update()
  vim.pack.update(nil, { force = true })

  vim.defer_fn(function()
    display_update_log()
  end, 1000)
end

return M
