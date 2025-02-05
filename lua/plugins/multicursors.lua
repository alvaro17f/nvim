local function is_active()
  local ok, hydra = pcall(require, "hydra.statusline")
  return ok and hydra.is_active()
end

return {
  "smoka7/multicursors.nvim",
  event = { "VeryLazy" },
  dependencies = { "nvimtools/hydra.nvim" },
  cmd = { "MCstart", "MCvisual", "MCclear", "MCpattern", "MCvisualPattern", "MCunderCursor" },
  keys = {
    {
      mode = { "v", "n" },
      "<Leader>m",
      function()
        vim.cmd("MCstart")
        if not is_active() then
          vim.cmd("MCunderCursor")
        end
      end,
      desc = "Multicursors",
    },
  },
  opts = {
    hint_config = {
      float_opts = {
        border = "rounded",
      },
      position = "bottom-right",
    },
  },
}
