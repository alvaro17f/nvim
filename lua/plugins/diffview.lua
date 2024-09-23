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
    { mode = "n", "<leader>gb", ":DiffviewFileHistory<CR>", silent = true, desc = "Diff branch" },
    { mode = "v", "<leader>gd", ":DiffviewFileHistory<CR>", silent = true, desc = "Diff visual" },
    { mode = "n", "<leader>gd", ":DiffviewFileHistory %<CR>", silent = true, desc = "Diff file" },
    { mode = "n", "<leader>gv", diffview_toggle, silent = true, desc = "Diff view" },
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
        diff1 = {
          { "n", "g?", actions.help({ "view", "diff1" }), { desc = "Open the help panel" } },
        },
        diff2 = {
          { "n", "g?", actions.help({ "view", "diff2" }), { desc = "Open the help panel" } },
        },
        diff3 = {
          { { "n", "x" }, "2do", actions.diffget("ours"), { desc = "Obtain the diff hunk from the OURS version of the file" } },
          { { "n", "x" }, "3do", actions.diffget("theirs"), { desc = "Obtain the diff hunk from the THEIRS version of the file" } },
          { "n", "g?", actions.help({ "view", "diff3" }), { desc = "Open the help panel" } },
        },
        diff4 = {
          { { "n", "x" }, "1do", actions.diffget("base"), { desc = "Obtain the diff hunk from the BASE version of the file" } },
          { { "n", "x" }, "2do", actions.diffget("ours"), { desc = "Obtain the diff hunk from the OURS version of the file" } },
          { { "n", "x" }, "3do", actions.diffget("theirs"), { desc = "Obtain the diff hunk from the THEIRS version of the file" } },
          { "n", "g?", actions.help({ "view", "diff4" }), { desc = "Open the help panel" } },
        },
        option_panel = {
          { "n", "<tab>", actions.select_entry, { desc = "Change the current option" } },
          { "n", "q", actions.close, { desc = "Close the panel" } },
          { "n", "g?", actions.help("option_panel"), { desc = "Open the help panel" } },
        },
        help_panel = {
          { "n", "q", actions.close, { desc = "Close help menu" } },
          { "n", "<esc>", actions.close, { desc = "Close help menu" } },
        },
      },
    }
  end,
}
