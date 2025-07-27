local contextual_filenames = {
  "index",
  "style",
}

return {
  "b0o/incline.nvim",
  event = { "BufReadPre" },
  priority = 1200,
  config = function()
    local helpers = require("incline.helpers")
    local devicons = require("nvim-web-devicons")
    local should_show_context = function(filename)
      for _, pattern in ipairs(contextual_filenames) do
        if filename:match(pattern) then
          return true
        end
      end
      return false
    end

    require("incline").setup({
      window = {
        padding = 0,
        margin = { horizontal = 0 },
      },
      render = function(props)
        local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
        if should_show_context(filename) then
          local filepath = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":p")
          local path_parts = {}

          for part in filepath:gmatch("[^/]+") do
            table.insert(path_parts, part)
          end
          if #path_parts > 1 then
            filename = path_parts[#path_parts - 1] .. "/" .. filename
          end
        elseif filename == "" then
          filename = "[No Name]"
        end
        local ft_icon, ft_color = devicons.get_icon_color(filename)
        local modified = vim.bo[props.buf].modified
        return {
          ft_icon and { " ", ft_icon, " ", guibg = ft_color, guifg = helpers.contrast_color(ft_color) } or "",
          " ",
          { filename, gui = modified and "bold,italic" or "bold" },
          " ",
          guibg = "#1e1e2e", -- default: #44406e
        }
      end,
    })
  end,
}
