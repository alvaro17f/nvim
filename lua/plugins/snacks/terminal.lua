local M = {}

M.config = {
  terminal = {
    enabled = true,
    win = {
      keys = {
        term_normal = {
          "<esc>",
          function(self)
            self.esc_timer = self.esc_timer or (vim.uv or vim.loop).new_timer()
            if self.esc_timer:is_active() then
              self.esc_timer:stop()
              vim.cmd("stopinsert")
            else
              self.esc_timer:start(200, 0, function() end)
              return "<esc>"
            end
          end,
          mode = "t",
          expr = true,
          desc = "Double escape to normal mode",
        },
        q = "hide",
        ["<esc>"] = "hide",
      },
    },
  },
}

M.keymaps = {
  -- vim.keymap.set({ "n", "t" }, "<C-\\>", function()
  -- 	Snacks.terminal.toggle()
  -- end, { desc = "Toggle Terminal" }),
  --
  -- vim.keymap.set("n", "<C-_>", function()
  -- 	Snacks.terminal()
  -- end, { desc = "which_key_ignore" }),
}

return M
