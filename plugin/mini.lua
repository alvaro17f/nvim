local utils = require("utils")

local path = vim.fn.stdpath("config") .. "/lua/plugins/mini/"

utils.require_modules(path)
