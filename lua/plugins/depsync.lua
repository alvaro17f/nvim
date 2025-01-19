return {
  "robertazzopardi/depsync.nvim",
  ft = { "json", "toml" },
  config = function()
    require("depsync").setup()
    vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
      group = vim.api.nvim_create_augroup("depsync", {}),
      pattern = { "package.json", "Cargo.toml" },
      callback = function()
        vim.cmd("DepSync")
      end,
    })
  end,
}
