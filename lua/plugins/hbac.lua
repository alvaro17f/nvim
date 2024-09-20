return {
  "axkirillov/hbac.nvim",
  lazy = false,
  keys = {
    { mode = "n", "<leader>b", ":Telescope hbac buffers<CR>", desc = "Telescope buffers" },
  },
  config = function()
    local actions = require("hbac.telescope.actions")
    require("hbac").setup({
      autoclose = true, -- set autoclose to false if you want to close manually
      threshold = 10, -- hbac will start closing unedited buffers once that number is reached
      close_command = function(bufnr)
        vim.api.nvim_buf_delete(bufnr, {})
      end,
      close_buffers_with_windows = false, -- hbac will close buffers with associated windows if this option is `true`
      telescope = {
        ignore_current_buffer = true,
        selection_strategy = "row",
        sort_lastused = true,
        sort_mru = true,
        use_default_mappings = true, -- false to not include the mappings below
        mappings = {
          i = {
            ["<c-x>"] = actions.delete_buffer,
            ["<c-p>"] = actions.toggle_pin,
          },
        },
      },
    })
  end,
}
