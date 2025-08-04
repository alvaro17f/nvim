local M = {}

local session = require("mini.sessions")

function M.has_valid_buffers()
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    local buflisted = vim.bo[bufnr].buflisted
    local readonly = vim.bo[bufnr].readonly
    local bufname = vim.api.nvim_buf_get_name(bufnr)

    if buflisted and not readonly then
      if bufname ~= "" then
        return true
      end
      local line_count = vim.api.nvim_buf_line_count(bufnr)
      if line_count > 1 or (line_count == 1 and vim.api.nvim_buf_get_lines(bufnr, 0, 1, false)[1] ~= "") then
        return true
      end
    end
  end
  return false
end

function M.select_session()
  local items = {}

  for name, value in pairs(session.detected) do
    table.insert(items, {
      text = name,
      modify_time = value.modify_time,
      path = value.path,
      type = value.type,
    })
  end

  table.sort(items, function(a, b)
    return a.modify_time > b.modify_time
  end)

  Snacks.picker.pick({
    source = "sessions",
    items = items,
    format = "text",
    layout = {
      preset = "select",
      layout = { title = " Select a session: " },
    },
    on_change = function()
      vim.cmd.startinsert()
    end,
    win = {
      input = {
        keys = {
          ["<c-c>"] = { "delete", mode = { "n", "i" } },
        },
      },
    },
    actions = {
      delete = function(picker, item)
        if item then
          session.delete(item.text, { verbose = false })
          vim.notify("Session deleted: " .. item.text, vim.log.levels.WARN)
          picker:close()
          vim.schedule(function()
            M.select_session()
          end)
        end
      end,
    },
    confirm = function(picker, item)
      if item then
        picker:close()
        vim.schedule(function()
          session.read(item.text, { verbose = false })
          vim.notify("Session read: " .. item.text, vim.log.levels.INFO)
        end)
      end
    end,
  })
end

function M.new_session(restore)
  local session_name = vim.fn.input("Session name: ")

  if session_name == "" then
    return vim.notify("Session save canceled", vim.log.levels.ERROR)
  end

  session.write(session_name .. ".vim", { verbose = false })
  vim.notify("Session created: " .. session_name, vim.log.levels.INFO)

  if restore then
    session.read(session_name .. ".vim", { verbose = false })
    vim.notify("Session read: " .. session_name, vim.log.levels.INFO)
  end
end

function M.restore_session()
  local latest_session_name = session.get_latest()
  session.read(latest_session_name)
  vim.notify("Session read: " .. latest_session_name, vim.log.levels.INFO)
end

return M
