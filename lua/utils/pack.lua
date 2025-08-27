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

        Snacks.win({
          buf = buf,
          width = math.min(80, vim.o.columns - 4),
          height = math.min(20, #trimmed_updates),
          row = 2,
          wo = {
            winblend = 10,
          },
        })
      end
    end
  end
end

function M.update()
  local all_plugins = vim.pack.get()
  vim.pack.update(all_plugins[#all_plugins + 1], { force = true })

  vim.defer_fn(function()
    display_update_log()
    require("utils.readme").generate_readme()
  end, 1000)
end

return M
