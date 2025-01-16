------------------------------------
--KEYMAPS
------------------------------------
local keymap = vim.api.nvim_set_keymap

--QUIT
keymap("n", "ZQ", ":quitall!<CR>", { noremap = true, silent = true, desc = "Quit all" })

--LAZY
keymap("n", "<leader>.", ":Lazy sync<CR>", { noremap = true, silent = true, desc = "Lazy sync" })

--PASTE YANK, NOT DELETED
keymap("n", "<leader>p", '"*p', { noremap = true, silent = true, desc = "Paste after from computer" })
keymap("n", "<leader>P", '"*P', { noremap = true, silent = true, desc = "Paste before from computer" })

--BUFFERS
keymap("n", "<leader><tab>", ":b#<CR>", { noremap = true, silent = true, desc = "Buffer switch back & forth" })
keymap("n", "[b", ":bp<CR>", { noremap = true, silent = true, desc = "Buffer previous" })
keymap("n", "]b", ":bn<CR>", { noremap = true, silent = true, desc = "Buffer next" })

--MOVE THROUGH WORKSPACES
keymap("n", "<Left>", ":wincmd h<CR>", { noremap = true, silent = true, desc = "Workspace left" })
keymap("n", "<Right>", ":wincmd l<CR>", { noremap = true, silent = true, desc = "Workspace right" })
keymap("n", "<Up>", ":wincmd k<CR>", { noremap = true, silent = true, desc = "Workspace up" })
keymap("n", "<Down>", ":wincmd j<CR>", { noremap = true, silent = true, desc = "Workspace down" })

keymap("n", "<c-h>", ":wincmd h<CR>", { noremap = true, silent = true, desc = "Workspace left" })
keymap("n", "<c-l>", ":wincmd l<CR>", { noremap = true, silent = true, desc = "Workspace right" })
keymap("n", "<c-k>", ":wincmd k<CR>", { noremap = true, silent = true, desc = "Workspace up" })
keymap("n", "<c-j>", ":wincmd j<CR>", { noremap = true, silent = true, desc = "Workspace down" })

--HJKL INSERT MODE
keymap("i", "<a-h>", "<left>", { noremap = true, silent = true, desc = "Left" })
keymap("i", "<a-j>", "<down>", { noremap = true, silent = true, desc = "Down" })
keymap("i", "<a-k>", "<up>", { noremap = true, silent = true, desc = "Up" })
keymap("i", "<a-l>", "<right>", { noremap = true, silent = true, desc = "Right" })

--BLOCK TO LINES (& AVOID EX MODE)
keymap("n", "Q", "gqq", { noremap = true, silent = true, desc = "Block to lines" })

--MOVE LINES
keymap("n", "<c-a-j>", ":m .+1<CR>==", { noremap = true, silent = true, desc = "Move line down" })
keymap("n", "<c-a-k>", ":m .-2<CR>==", { noremap = true, silent = true, desc = "Move line up" })
keymap("i", "<c-a-j>", "<Esc>:m .+1<CR>==gi", { noremap = true, silent = true, desc = "Move line down" })
keymap("i", "<c-a-k>", "<Esc>:m .-2<CR>==gi", { noremap = true, silent = true, desc = "Move line up" })
keymap("v", "<c-a-j>", ":m '>+1<CR>gv=gv", { noremap = true, silent = true, desc = "Move line down" })
keymap("v", "<c-a-k>", ":m '<-2<CR>gv=gv", { noremap = true, silent = true, desc = "Move line up" })