return {
  "sudo-tee/opencode.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("opencode").setup({
      prefered_picker = nil,
      default_global_keymaps = true,
      default_mode = "plan",
      config_file_path = nil,
    })
  end,
}
