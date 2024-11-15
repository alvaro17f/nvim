vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

return {
  "rmagatti/auto-session",
  lazy = false,
  opts = {
    auto_create = function()
      local cmd = "git rev-parse --is-inside-work-tree"
      return vim.fn.system(cmd) == "true\n"
    end,
    bypass_save_filetypes = { "alpha", "dashboard" },
    session_lens = {
      load_on_setup = true,
      previewer = false,
      mappings = {
        delete_session = { "i", "<C-C>" },
        alternate_session = { "i", "<C-S>" },
        copy_session = { "i", "<C-Y>" },
      },
      theme_conf = {
        border = true,
      },
    },
    suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
  },
  keys = {
    { "<leader>ww", ":SessionSearch<CR>", desc = "Session search" },
    { "<leader>ws", ":SessionSave ", desc = "Save session" },
  },
}
