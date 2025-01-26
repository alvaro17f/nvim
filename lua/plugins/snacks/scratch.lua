local widths = { 0, 0, 0, 0 }
local function generate_text(items)
  for _, item in ipairs(items) do
    item._path = item.file
    item.branch = item.branch and ("branch:%s"):format(item.branch) or ""
    item.cwd = item.cwd and vim.fn.fnamemodify(item.cwd, ":p:~") or ""
    item.icon = item.icon or Snacks.util.icon(item.ft, "filetype")
    item.preview = { text = item.file }
    widths[1] = math.max(widths[1], vim.api.nvim_strwidth(item.cwd))
    widths[2] = math.max(widths[2], vim.api.nvim_strwidth(item.icon))
    widths[3] = math.max(widths[3], vim.api.nvim_strwidth(item.name))
    widths[4] = math.max(widths[4], vim.api.nvim_strwidth(item.branch))
  end
end

local function format_item_text(element)
  local parts = { element.cwd, element.icon, element.name, element.branch }
  for i, part in ipairs(parts) do
    parts[i] = part .. string.rep(" ", widths[i] - vim.api.nvim_strwidth(part))
  end
  return table.concat(parts, " ")
end

local function select_scratch()
  local items = Snacks.scratch.list()
  generate_text(items)

  Snacks.picker.pick({
    source = "snacks.scratch",
    items = items,
    format = "text",
    layout = {
      layout = { title = " Select Scratch Buffer: " },
      preview = true,
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
        select_scratch()
      end,
    },
    confirm = function(_, item)
      if item then
        Snacks.scratch.open({ icon = item.icon, file = item.file, name = item.name, ft = item.ft })
      end
    end,
  })
end

return {
  "snacks.nvim",
  keys = {
    {
      "-",
      function()
        Snacks.scratch()
      end,
      desc = "Toggle Scratch Buffer",
    },
    {
      "_",
      function()
        select_scratch()
      end,
      desc = "Select Scratch Buffer",
    },
  },
}
