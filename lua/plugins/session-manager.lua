return {
  "Shatur/neovim-session-manager",
  keys = {
    {
      mode = "n",
      "<leader>ww",
      function()
        require("session_manager").load_session(false)
      end,
      desc = "Select session",
    },
    {
      mode = "n",
      "<leader>w<backspace>",
      function()
        require("session_manager").load_last_session()
      end,
      desc = "Restore last session",
    },
    {
      mode = "n",
      "<leader>ws",
      function()
        require("session_manager").save_current_session()
      end,
      desc = "Save session",
    },
    {
      mode = "n",
      "<leader>wd",
      function()
        require("session_manager").delete_session()
      end,
      desc = "Delete session",
    },
  },
  config = function()
    require("session_manager").setup({
      autoload_mode = require("session_manager.config").AutoloadMode.CurrentDir, -- Possible values: Disabled, CurrentDir, LastSession
      autosave_ignore_not_normal = true, -- Plugin will not save a session when no buffers are opened, or all of them aren't writable or listed.
      autosave_ignore_dirs = { "~" },
    })
  end,
}
