local filetypes = {
  { text = "css" },
  { text = "go" },
  { text = "html" },
  { text = "javascript" },
  { text = "javascriptreact" },
  { text = "json" },
  { text = "lua" },
  { text = "markdown" },
  { text = "python" },
  { text = "rust" },
  { text = "typescript" },
  { text = "typescriptreact" },
  { text = "zig" },
}

return {
  "snacks.nvim",
  keys = {
    {
      "-",
      function()
        require("utils.snacks.scratch").new_scratch(filetypes)
      end,
      desc = "Toggle Scratch Buffer",
    },
    {
      "_",
      function()
        require("utils.snacks.scratch").select_scratch()
      end,
      desc = "Select Scratch Buffer",
    },
  },
}
