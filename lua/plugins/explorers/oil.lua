Pack.add({ "https://github.com/stevearc/oil.nvim" })

local oil = require("oil")

local go_to = function(dir)
  if vim.fn.isdirectory(dir) then
    return "<CMD>edit " .. dir .. "<CR>"
  end
end

oil.setup({
  default_file_explorer = true,
  delete_to_trash = true,
  skip_confirm_for_simple_edits = true,
  view_options = {
    show_hidden = true,
    natural_order = true,
    case_insensitive = true,
    is_always_hidden = function(name, _)
      return name == ".." or name == ".git"
    end,
  },
  -- float = {
  --   max_width = 90,
  --   win_options = {
  --     winblend = 10,
  --   },
  -- },
  use_default_keymaps = false,
  --stylua: ignore
  keymaps = {
    ["g?"] = "actions.show_help",
    ["q"] = "actions.close",
    ["h"] = "actions.parent",
    ["l"] = "actions.select",
    ["<BS>"] = "actions.open_cwd",
    [";"] = "actions.cd", -- [";"] = { "actions.cd", opts = { scope = "tab" }, desc = ":tcd to the current oil directory" },
    ["<localleader>p"] = "actions.preview",
    ["<localleader>."] = "actions.toggle_hidden",
    ["<localleader>r"] = "actions.refresh",
    ["<localleader>,"] = "actions.change_sort",
    ["<localleader>\\"] = "actions.toggle_trash",
    ["gh"] = go_to("$HOME"),
    ["gc"] = go_to("$HOME/.config"),
    ["gd"] = go_to("$HOME/Downloads"),
    ["gx"] = go_to("$HOME/Documents"),
    ["gn"] = go_to(vim.fn.stdpath("config")),
    ["<c-w>v"] = { "actions.select", opts = { vertical = true }, desc = "Open the entry in a vertical split" },
    ["<c-w>s"] = { "actions.select", opts = { horizontal = true }, desc = "Open the entry in a horizontal split" },
  },
})

vim.keymap.set("n", "<leader>/", function()
  oil.open_float(nil, { preview = {} })
end, { desc = "File explorer" })
