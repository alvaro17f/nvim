vim.pack.add({ "https://github.com/lewis6991/gitsigns.nvim" }, { load = true, confirm = false })

local signs = {
  add = { text = "▎" },
  change = { text = "▎" },
  delete = { text = "" },
  topdelete = { text = "" },
  changedelete = { text = "▎" },
  untracked = { text = "▎" },
}

local gitsigns = require("gitsigns")

gitsigns.setup({
  preview_config = { border = "rounded" },
  current_line_blame = true,
  sign_priority = 0,
  signs = signs,
  signs_staged = signs,
})

vim.keymap.set("n", "<leader>g;", function()
  gitsigns.toggle_linehl()
  gitsigns.toggle_deleted()
  gitsigns.toggle_word_diff()
end, { desc = "Preview hunk inline" })

vim.keymap.set("n", "[g", function()
  gitsigns.nav_hunk("prev", { target = "all" })
end, { desc = "Previous hunk" })

vim.keymap.set("n", "]g", function()
  gitsigns.nav_hunk("next", { target = "all" })
end, { desc = "Next hunk" })

vim.keymap.set("n", "<leader>gb", function()
  gitsigns.blame_line()
end, { desc = "Blame line" })

vim.keymap.set("n", "<leader>gb", function()
  gitsigns.blame_line()
end, { desc = "Diff this" })

vim.keymap.set("n", "<leader>gd", function()
  gitsigns.diffthis("~")

  vim.keymap.set("n", "q", function()
    for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
      local buf = vim.api.nvim_win_get_buf(win)
      local bufname = vim.api.nvim_buf_get_name(buf)
      if bufname:find("^gitsigns://") then
        vim.api.nvim_win_close(win, true)
        break
      end
    end
    vim.wo.diff = false
    return ""
  end, { desc = "Close diff" })
end)
