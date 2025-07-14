local M = {}

local function generate_uuid()
  local random = math.random
  local template = "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx"
  return string.gsub(template, "[xy]", function(c)
    local v = (c == "x") and random(0, 0xf) or random(8, 0xb)
    return string.format("%x", v)
  end)
end

local column_widths = { 0, 0, 0, 0 }

local function update_column_widths(item)
  column_widths[1] = math.max(column_widths[1], vim.api.nvim_strwidth(item.cwd))
  column_widths[2] = math.max(column_widths[2], vim.api.nvim_strwidth(item.icon))
  column_widths[3] = math.max(column_widths[3], vim.api.nvim_strwidth(item.name))
  column_widths[4] = math.max(column_widths[4], vim.api.nvim_strwidth(item.branch))
end

local function process_item(item)
  item._path = item.file
  item.branch = item.branch and ("branch:%s"):format(item.branch) or ""
  item.cwd = item.cwd and vim.fn.fnamemodify(item.cwd, ":p:~") or ""
  item.icon = item.icon or Snacks.util.icon(item.ft, "filetype")
  item.preview = { text = item.file }
  item.name = "Scratch"
  update_column_widths(item)
end

local function process_items(items)
  for _, item in ipairs(items) do
    process_item(item)
  end
end

local function format_item_text(item)
  local parts = { item.cwd, item.icon, item.name, item.branch }
  for i, part in ipairs(parts) do
    parts[i] = part .. string.rep(" ", column_widths[i] - vim.api.nvim_strwidth(part))
  end
  return table.concat(parts, " ")
end

function M.select_scratch()
  local items = Snacks.scratch.list()
  process_items(items)

  Snacks.picker.pick({
    source = "scratch",
    items = items,
    format = "text",
    layout = {
      layout = { title = " Select Scratch Buffer: " },
      preset = function()
        return vim.o.columns >= 120 and "default" or "vertical"
      end,
    },
    on_change = function()
      vim.cmd.startinsert()
    end,
    transform = function(item)
      item.text = format_item_text(item)
    end,
    win = {
      input = {
        keys = {
          ["<c-x>"] = { "delete", mode = { "i", "n" } },
        },
      },
    },
    actions = {
      delete = function(picker, item)
        for _, entry in ipairs(items) do
          if entry.cwd == item.cwd then
            os.remove(item.file)
          end
        end
        picker:close()

        vim.schedule(function()
          M.select_scratch()
        end)
      end,
    },
    confirm = function(picker, item)
      if item then
        picker:close()
        Snacks.scratch.open({
          icon = item.icon,
          file = item.file,
          name = item.name,
          ft = item.ft,
        })
      end
    end,
  })
end

function M.new_scratch(filetypes)
  Snacks.picker.pick({
    source = "scratch",
    items = filetypes,
    format = "text",
    layout = {
      preset = "vscode",
      layout = { title = " Select a filetype: " },
    },
    actions = {
      confirm = function(picker, item)
        picker:close()
        vim.schedule(function()
          local items = picker:items()
          if #items == 0 then
            Snacks.scratch({ ft = picker:filter().pattern, name = generate_uuid() })
          else
            Snacks.scratch({ ft = item.text, name = generate_uuid() })
          end
        end)
      end,
    },
  })
end

return M
