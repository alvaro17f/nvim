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
  event = { "BufReadPre", "BufNewFile" },
  cmd = { "DiffviewOpen", "DiffviewFileHistory" },
  --stylua: ignore
  keys = {
    { mode = "n", "<leader>gh", "<CMD>DiffviewFileHistory<CR>", silent = true, desc = "Diff branch history" },
    { mode = "v", "<leader>gd", "<ESC><CMD>'<,'>DiffviewFileHistory --follow<CR>", silent = true, desc = "Diff visual" },
    { mode = "n", "<leader>gd", "<CMD>DiffviewFileHistory --follow %<CR>", silent = true, desc = "Diff file" },
    { mode = "n", "<leader>gv", diffview_toggle, silent = true, desc = "Diff view" },
  },
  opts = function()
    local actions = require("diffview.actions")

    return {
      enhanced_diff_hl = true,
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
      hooks = {
        view_opened = function()
          actions.toggle_files()
        end,
      },
      --stylua: ignore
      keymaps = {
        disable_defaults = true,
        view = {
          { "n", "q", diffview_toggle, { desc = "Quit" } },
          { "n", "<Tab>", actions.select_next_entry, { desc = "Select next entry" } },
          { "n", "<S-Tab>", actions.select_prev_entry, { desc = "Select Previous entry" } },
          { "n", "<localleader>o", actions.goto_file_tab, { desc = "Open file" } },
          { "n", "<LocalLeader>e", actions.toggle_files, { desc = "Toggle Files" } },
        },
        file_panel = {
          { "n", "q", diffview_toggle, { desc = "Quit" } },
          { "n", "<cr>", actions.select_entry, { desc = "Select entry" } },
          { "n", "<right>", actions.select_entry, { desc = "Select entry" } },
          { "n", "l", actions.select_entry, { desc = "Select entry" } },
          { "n", "<tab>", actions.next_entry, { desc = "Select next entry" } },
          { "n", "<down>", actions.next_entry, { desc = "Select next entry" } },
          { "n", "j", actions.next_entry, { desc = "Select next entry" } },
          { "n", "<s-tab>", actions.prev_entry, { desc = "Select previous entry" } },
          { "n", "<up>", actions.prev_entry, { desc = "Select previous entry" } },
          { "n", "<k>", actions.prev_entry, { desc = "Select previous entry" } },
          { "n", "<localleader><localleader>", actions.toggle_stage_entry, { desc = "Stage entry" } },
          { "n", "<localleader>s", actions.stage_all, { desc = "Stage all" } },
          { "n", "<localleader>u", actions.unstage_all, { desc = "Unstage all" } },
          { "n", "<localleader>x", actions.restore_entry, { desc = "Restore entry to the state on the left side" } },
          { "n", "<localleader>o", actions.goto_file_tab, { desc = "Open file" } },
          { "n", "<localleader>r", actions.refresh_files, { desc = "Refresh" } },
          { "n", "<LocalLeader>e", actions.toggle_files, { desc = "Select Previous entry" } },
          { "n", "g?", actions.help("file_panel"), { desc = "Open the help panel" } },
        },
        file_history_panel = {
          { "n", "q", diffview_toggle, { desc = "Quit" } },
          { "n", "<cr>", actions.select_entry, { desc = "Select entry" } },
          { "n", "<right>", actions.select_entry, { desc = "Select entry" } },
          { "n", "l", actions.select_entry, { desc = "Select entry" } },
          { "n", "<tab>", actions.next_entry, { desc = "Select next entry" } },
          { "n", "<down>", actions.next_entry, { desc = "Select next entry" } },
          { "n", "j", actions.next_entry, { desc = "Select next entry" } },
          { "n", "<s-tab>", actions.prev_entry, { desc = "Select previous entry" } },
          { "n", "<up>", actions.prev_entry, { desc = "Select previous entry" } },
          { "n", "<k>", actions.prev_entry, { desc = "Select previous entry" } },
          { "n", "<localleader>o", actions.goto_file_tab, { desc = "Open file" } },
          { "n", "X", actions.restore_entry, { desc = "Restore file to the state from the selected entry" } },
          { "n", "g!", actions.options, { desc = "Open the option panel" } },
          { "n", "g?", actions.help("file_history_panel"), { desc = "Open the help panel" } },
        },
        help_panel = {
          { "n", "q", actions.close, { desc = "Close help menu" } },
          { "n", "<esc>", actions.close, { desc = "Close help menu" } },
        },
      },
    }
  end,
}
