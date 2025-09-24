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
  vim.keymap.set({ "n", "t" }, "<c-a>", function() require("opencode").toggle() end, { desc = "Toggle embedded opencode" })
  vim.keymap.set("n", "<leader>aa", function() require("opencode").ask() end, { desc = "Ask opencode" })
  vim.keymap.set("v", "<leader>aa", function() require("opencode").ask("@selection: ") end, { desc = "Ask opencode about selection" })
  vim.keymap.set("n", "<leader>ab", function() require("opencode").ask("@buffer: ") end, { desc = "Ask opencode about current buffer" })
  vim.keymap.set("n", "<leader>ac", function() require("opencode").ask("@cursor: ") end, { desc = "Ask opencode about current cursor" })
  vim.keymap.set({"n", "v"}, "<leader>as", function() require("opencode").select() end, { desc = "Select prompt" })
  vim.keymap.set("n", "<leader>an", function() require("opencode").command("session_new") end, { desc = "New session", })
  vim.keymap.set("n", "<leader>ay", function() require("opencode").command("messages_copy") end, { desc = "Copy last message", })
  vim.keymap.set('n', '<leader>ae', function() require('opencode').prompt("Explain @cursor and its context") end, { desc = "Explain code near cursor" })
--stylua: ignore end
