Pack.add({ "https://github.com/NickvanDyke/opencode.nvim" })

vim.o.autoread = true

vim.g.opencode_opts = {
  port = nil,
  auto_reload = true,
  terminal = {
    win = {
      enter = true,
      position = "right",
      bo = {
        filetype = "opencode_terminal",
      },
    },
  },
}

--stylua: ignore start
  vim.keymap.set({ "n", "t" }, "<C-/>", function() require("opencode").toggle() end, { desc = "Toggle embedded opencode" })
  vim.keymap.set("n", "<leader>oa", function() require("opencode").ask() end, { desc = "Ask opencode" })
  vim.keymap.set("v", "<leader>oa", function() require("opencode").ask("@selection: ") end, { desc = "Ask opencode about selection" })
  vim.keymap.set("n", "<leader>ob", function() require("opencode").ask("@buffer: ") end, { desc = "Ask opencode about current buffer" })
  vim.keymap.set("n", "<leader>oc", function() require("opencode").ask("@cursor: ") end, { desc = "Ask opencode about current cursor" })
  vim.keymap.set({"n", "v"}, "<leader>os", function() require("opencode").select() end, { desc = "Select prompt" })
  vim.keymap.set("n", "<leader>on", function() require("opencode").command("session_new") end, { desc = "New session", })
  vim.keymap.set("n", "<leader>oy", function() require("opencode").command("messages_copy") end, { desc = "Copy last message", })
  vim.keymap.set("t", "<S-C-u>", function() require("opencode").command("messages_half_page_up") end, { desc = "Scroll messages up" })
  vim.keymap.set("t", "<S-C-d>", function() require("opencode").command("messages_half_page_down") end, { desc = "Scroll messages down" })
  vim.keymap.set('n', '<leader>oe', function() require('opencode').prompt("Explain @cursor and its context") end, { desc = "Explain code near cursor" })
--stylua: ignore end
