Pack.add({ "https://github.com/onlyati/quadlet-lsp.nvim" })

local quadlet_lsp = require("quadlet-lsp")
local utils = require("plugins.quadlet.utils")

utils.ensure_quadlet_lsp_binary()

quadlet_lsp.setup()
