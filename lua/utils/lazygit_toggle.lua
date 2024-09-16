local term = nil

local function lg_toggle()
	local Terminal = require("toggleterm.terminal").Terminal

	local size = 90
	local direction = "float"

	if not term then
		term = Terminal:new({
			cmd = "lazygit",
			hidden = true,
			count = 0,
			on_exit = function()
				term = nil
			end,
		})
		if term then
			term:toggle(size, direction)

			vim.cmd("set ft=lazygit")
			vim.keymap.set("t", "<a-q>", function()
				term:toggle(size, direction)
			end, { buffer = true })
		end
	else
		term:toggle(size, direction)
	end
end

vim.api.nvim_create_user_command("LazyGitToggle", lg_toggle, {})
vim.keymap.set("n", "<leader>gg", function()
	if require("utils.is_git_repo")() then
		vim.cmd("LazyGitToggle")
	end
end, {
	silent = true,
	desc = "Lazygit",
})
