---@diagnostic disable: param-type-mismatch

vim.pack.add({ "https://github.com/lewis6991/gitsigns.nvim" }, { load = true, confirm = false })

local icons = require("utils.icons").gitsigns

local signs = {
  add = { text = icons.add },
  change = { text = icons.change },
  delete = { text = icons.delete },
  topdelete = { text = icons.topdelete },
  changedelete = { text = icons.changedelete },
  untracked = { text = icons.untracked },
}

local gitsigns = require("gitsigns")

gitsigns.setup({
  preview_config = { border = "rounded" },
  current_line_blame = true,
  signs = signs,
  signs_staged = signs,
  numhl = true,
})

-- https://github.com/lewis6991/gitsigns.nvim/discussions/1373
vim.api.nvim_create_autocmd("User", {
  pattern = "GitSignsUpdate",
  callback = function()
    vim.cmd("redrawstatus")
  end,
})

vim.keymap.set("n", "<leader>g;", function()
  gitsigns.toggle_linehl()
  gitsigns.toggle_deleted()
  gitsigns.toggle_word_diff()
end, { desc = "Toggle diff" })

vim.keymap.set("n", "[g", function()
  gitsigns.nav_hunk("prev", { target = "all" })
end, { desc = "Previous hunk" })

vim.keymap.set("n", "]g", function()
  gitsigns.nav_hunk("next", { target = "all" })
end, { desc = "Next hunk" })

vim.keymap.set("n", "<leader>gb", function()
  gitsigns.blame_line()
end, { desc = "Blame line" })

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
end, { desc = "Diff this" })
