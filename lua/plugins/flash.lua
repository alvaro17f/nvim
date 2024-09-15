return {
	"folke/flash.nvim",
	event = "VeryLazy",
	---@diagnostic disable-next-line: undefined-doc-name
	---@type Flash.Config
	opts = {},
  --stylua: ignore
  keys = {
    { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
  },
}