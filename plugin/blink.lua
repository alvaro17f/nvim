if vim.g.autocomplete then
  return {}
end

local utils = require("utils")

local path = vim.fn.stdpath("config") .. "/lua/plugins/blink/"

utils.require_modules(path)
