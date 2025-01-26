local current_session = nil
local sessions_directory = vim.fn.stdpath("data") .. "/sessions/"

local function has_valid_buffers()
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

local function session_selector()
  local session = require("mini.sessions")

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
    source = "mini.sessions",
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
          ["<c-x>"] = { "delete", mode = { "n", "i" } },
        },
      },
    },
    actions = {
      delete = function(picker, item)
        if item then
          session.delete(item.text, { verbose = false })
          vim.notify("Session deleted: " .. item.text, vim.log.levels.WARN)
          picker:close()
          session_selector()
        end
      end,
    },
    confirm = function(picker, item)
      if item then
        picker:close()
        session.read(item.text, { verbose = false })
        vim.notify("Session read: " .. item.text, vim.log.levels.INFO)
      end
    end,
  })
end

local function session_maker()
  local session = require("mini.sessions")
  local session_name = vim.fn.input("Session name: ")

  if session_name == "" then
    return vim.notify("Session save canceled", vim.log.levels.ERROR)
  end

  session.write(session_name .. ".vim", { verbose = false })
  vim.notify("Session created: " .. session_name, vim.log.levels.INFO)
end

local function session_restore()
  local session = require("mini.sessions")
  local latest_session_name = session.get_latest()
  session.read(latest_session_name)
  vim.notify("Session read: " .. latest_session_name, vim.log.levels.INFO)
end

return {
  "echasnovski/mini.sessions",
  event = { "VeryLazy" },
  version = false,
  keys = {
    {
      "<leader>wl",
      function()
        session_selector()
      end,
      desc = "Load session",
    },
    {
      "<leader>ws",
      function()
        session_maker()
      end,
      desc = "Save session",
    },
    {
      "<leader>w<backspace>",
      function()
        session_restore()
      end,
      desc = "Load last session",
    },
    {
      "<leader>ww",
      function()
        if current_session then
          vim.notify("Current session: " .. current_session, vim.log.levels.INFO)
        else
          vim.notify("No current session", vim.log.levels.WARN)
        end
      end,
      desc = "Current session",
    },
  },
  opts = {
    autoread = false,
    autowrite = true,
    directory = sessions_directory,
    file = "", -- File for local session (use `''` to disable)
    force = { read = false, write = true, delete = true },
    hooks = {
      pre = {
        read = nil,
        write = function()
          local edgy, diffview, dap, dapui = require("edgy"), require("diffview.lib"), require("dap"), require("dapui")

          edgy.close()

          if diffview.get_current_view() then
            vim.cmd.DiffviewClose()
          end

          if vim.g.debugger and dap.session() ~= nil then
            dapui.close()
          end
        end,
        delete = nil,
      },
      post = {
        read = function(item)
          current_session = item.name
        end,
        write = nil,
        delete = nil,
      },
    },
    verbose = { read = false, write = true, delete = true },

    vim.api.nvim_create_autocmd("VimLeavePre", {
      callback = function()
        if has_valid_buffers() and not current_session then
          local session = require("mini.sessions")
          session.write("draft.vim")
        end
      end,
    }),
  },
}
