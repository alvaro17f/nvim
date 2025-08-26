vim.pack.add({
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects", version = "main" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter-context" },
  { src = "https://github.com/windwp/nvim-ts-autotag" },
}, { load = true, confirm = false })

local autotag = require("nvim-ts-autotag")
local context = require("treesitter-context")
local treesitter = require("nvim-treesitter")

treesitter.setup()

local ensure_installed = { "regex" }
local already_installed = treesitter.get_installed()
local parsers_to_install = vim
  .iter(ensure_installed)
  :filter(function(parser)
    return not vim.tbl_contains(already_installed, parser)
  end)
  :totable()

if #parsers_to_install > 0 then
  treesitter.install(parsers_to_install)
end

local function ts_start(bufnr, parser_name)
  vim.treesitter.start(bufnr, parser_name)

  vim.schedule(function()
    vim.bo[bufnr].syntax = "ON"
    vim.wo.foldlevel = 99
    vim.wo.foldmethod = "expr"
    vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    vim.wo.foldtext = "v:lua.vim.lsp.foldtext()" --"v:lua.vim.treesitter.foldtext()"
    vim.bo[bufnr].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end)
end

vim.api.nvim_create_autocmd({ "FileType" }, {
  desc = "Enable Treesitter",
  callback = function(event)
    local bufnr = event.buf
    local filetype = event.match

    if filetype == "" then
      return
    end

    local parser_name = vim.treesitter.language.get_lang(filetype)
    if not parser_name then
      vim.notify(vim.inspect("No treesitter parser found for filetype: " .. filetype), vim.log.levels.WARN)
      return
    end

    if not vim.tbl_contains(treesitter.get_available(), parser_name) then
      return
    end

    if not vim.tbl_contains(already_installed, parser_name) then
      treesitter.install({ parser_name }):await(function()
        ts_start(bufnr, parser_name)
      end)
      return
    end

    ts_start(bufnr, parser_name)
  end,
})

vim.api.nvim_create_autocmd("PackChanged", {
  desc = "Update treesitter parsers",
  callback = function(event)
    if event.data.spec.name == "nvim-treesitter" and event.data.kind == "update" then
      vim.schedule(function()
        vim.cmd("TSUpdate")
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
