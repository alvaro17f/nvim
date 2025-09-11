------------------------------------
-- KEYMAPS
------------------------------------
local keymap = vim.keymap.set
local icons = require("utils.icons")

-- QUIT
keymap("n", "ZQ", "<CMD>quitall!<CR>", { noremap = true, silent = true, desc = "Quit all" })

-- RESTART
keymap("n", "ZR", "<CMD>restart<CR>", { noremap = true, silent = true, desc = "Restart" })

-- AUTO SAVE
keymap("n", "<leader>*", function()
  vim.g.autosave = not vim.g.autosave
  local icon = vim.g.autosave and icons.core.toggle.enabled or icons.core.toggle.disabled
  vim.notify(icon .. " Auto save: " .. (vim.g.autosave and "enabled" or "disabled"), vim.log.levels.INFO)
end, { noremap = true, silent = true, desc = "Toggle auto save" })

-- UPDATE
keymap("n", "<leader>.", function()
  require("utils.pack").update()
end, { noremap = true, silent = true, desc = "Update plugins" })

-- FLAGS
keymap("n", "<leader>F", function()
  require("utils.flags").toggle()
end, { noremap = true, silent = true, desc = "Flags" })

-- PASTE YANK, NOT DELETED
keymap("n", "<leader>p", '"*p', { noremap = true, silent = true, desc = "Paste after from computer" })
keymap("n", "<leader>P", '"*P', { noremap = true, silent = true, desc = "Paste before from computer" })

-- BUFFERS
keymap("n", "<leader><tab>", "<CMD>b#<CR>", { noremap = true, silent = true, desc = "Buffer switch back & forth" })

-- HJKL INSERT MODE
keymap("i", "<a-h>", "<left>", { noremap = true, silent = true, desc = "Left" })
keymap("i", "<a-j>", "<down>", { noremap = true, silent = true, desc = "Down" })
keymap("i", "<a-k>", "<up>", { noremap = true, silent = true, desc = "Up" })
keymap("i", "<a-l>", "<right>", { noremap = true, silent = true, desc = "Right" })

-- MOVE LINES
keymap("n", "<c-a-j>", "<CMD>m .+1<CR>==", { noremap = true, silent = true, desc = "Move line down" })
keymap("n", "<c-a-k>", "<CMD>m .-2<CR>==", { noremap = true, silent = true, desc = "Move line up" })
keymap("i", "<c-a-j>", "<Esc><CMD>m .+1<CR>==gi", { noremap = true, silent = true, desc = "Move line down" })
keymap("i", "<c-a-k>", "<Esc><CMD>m .-2<CR>==gi", { noremap = true, silent = true, desc = "Move line up" })
keymap("v", "<c-a-j>", "<ESC><CMD>'<,'>m '>+1<CR>gv=gv", { noremap = true, silent = true, desc = "Move line down" })
keymap("v", "<c-a-k>", "<ESC><CMD>'<,'>m '<-2<CR>gv=gv", { noremap = true, silent = true, desc = "Move line up" })

-- MESSAGES
keymap("n", "<leader>M", "<CMD>messages<CR>", { noremap = true, silent = true, desc = "Messages" })
