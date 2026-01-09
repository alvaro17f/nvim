Pack.add({
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects", version = "main" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter-context" },
  { src = "https://github.com/windwp/nvim-ts-autotag" },
})

vim.g.no_plugin_maps = true -- Disable entire built-in ftplugin mappings to avoid conflicts with textobjects.

local autotag = require("nvim-ts-autotag")
local context = require("treesitter-context")
local treesitter = require("nvim-treesitter")

treesitter.setup()

local ensure_installed = {
  "lua",
  "markdown",
  "markdown_inline",
  "regex",
  "vimdoc",
}

vim.api.nvim_create_autocmd("FileType", {
  desc = "Enable Treesitter",
  pattern = { "*" },
  callback = function(args)
    local buf = args.buf
    local filetype = vim.bo[buf].filetype
    local language = vim.treesitter.language.get_lang(filetype) or filetype
    local parsers = vim.tbl_extend("force", ensure_installed, { language })
    local available = vim.g.ts_available or treesitter.get_available()

    if not vim.tbl_contains(available, language) then
      return
    end

    treesitter.install(parsers):await(function()
      if not vim.treesitter.language.add(language) then
        return
      end

      if pcall(vim.treesitter.start, buf, language) then
        vim.bo[buf].syntax = "ON"
        vim.wo.foldlevel = 99
        vim.wo.foldmethod = "expr"
        vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
        vim.wo.foldtext = "v:lua.vim.lsp.foldtext()" --"v:lua.vim.treesitter.foldtext()"
        vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end
    end)
  end,
})

vim.api.nvim_create_autocmd("PackChanged", {
  desc = "Update treesitter parsers",
  callback = function(args)
    if args.data.spec and args.data.spec.name == "nvim-treesitter" and args.data.kind == "update" then
      vim.schedule(function()
        treesitter.update()
      end)
    end
  end,
})

context.setup({
  enable = true,
  mode = "cursor", -- 'cursor' 'topline'
  max_lines = 3,
})

autotag.setup({
  opts = {
    enable_close = true, -- Auto close tags
    enable_rename = true, -- Auto rename pairs of tags
    enable_close_on_slash = false, -- Auto close on trailing </
  },
})
