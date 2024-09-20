local function diffview_toggle()
  local lib = require("diffview.lib")
  local view = lib.get_current_view()
  if view then
    vim.cmd.DiffviewClose()
  else
    vim.cmd.DiffviewOpen()
  end
end

return {
  "sindrets/diffview.nvim",
  cmd = { "DiffviewOpen", "DiffviewFileHistory" },
  keys = {
    { mode = "n", "<leader>gh", ":DiffviewFileHistory<CR>", silent = true, desc = "Diff branch history" },
    { mode = "n", "<leader>gf", ":DiffviewFileHistory %<CR>", silent = true, desc = "Diff file history" },
    { mode = "n", "<leader>g\\", diffview_toggle, silent = true, desc = "Diff view toggle" },
  },
  opts = function()
    local actions = require("diffview.actions")
    vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
      group = vim.api.nvim_create_augroup("rafi_diffview", {}),
      pattern = "diffview:///panels/*",
      callback = function()
        vim.opt_local.cursorline = true
        vim.opt_local.winhighlight = "CursorLine:WildMenu"
      end,
    })

    return {
      enhanced_diff_hl = true,
      keymaps = {
        view = {
          { "n", "q", actions.close },
          { "n", "<Tab>", actions.select_next_entry },
          { "n", "<S-Tab>", actions.select_prev_entry },
          { "n", "<LocalLeader>a", actions.focus_files },
          { "n", "<LocalLeader>e", actions.toggle_files },
        },
        file_panel = {
          { "n", "q", actions.close },
          { "n", "h", actions.prev_entry },
          { "n", "o", actions.focus_entry },
          { "n", "gf", actions.goto_file },
          { "n", "sg", actions.goto_file_split },
          { "n", "st", actions.goto_file_tab },
          { "n", "<C-r>", actions.refresh_files },
          { "n", "<LocalLeader>e", actions.toggle_files },
        },
        file_history_panel = {
          { "n", "q", "<cmd>DiffviewClose<CR>" },
          { "n", "o", actions.focus_entry },
          { "n", "O", actions.options },
        },
      },
      file_panel = {
        listing_style = "list", -- 'list', 'tree'
        tree_options = {
          flatten_dirs = true,
          folder_statuses = "only_folded", -- 'never', 'only_folded', 'always'.
        },
        win_config = {
          position = "left",
          width = 35,
          win_opts = {},
        },
      },
    }
  end,
}
