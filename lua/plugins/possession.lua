return {
  "gennaro-tedesco/nvim-possession",
  keys = {
    {
      mode = "n",
      "<leader>ww",
      function()
        require("nvim-possession").list()
      end,
      desc = "List all sessions",
    },
    {
      mode = "n",
      "<leader>wn",
      function()
        require("nvim-possession").new()
      end,
      desc = "New session",
    },
    {
      mode = "n",
      "<leader>ws",
      function()
        require("nvim-possession").update()
      end,
      desc = "Save session",
    },
    {
      mode = "n",
      "<leader>wd",
      function()
        require("nvim-possession").delete()
      end,
      desc = "Delete current session",
    },
  },
  config = function()
    require("nvim-possession").setup({
      sessions = {
        sessions_path = vim.fn.stdpath("data") .. "/sessions/",
        sessions_variable = "session",
        sessions_icon = "📌",
        sessions_prompt = "sessions: ",
      },

      autoload = false, -- whether to autoload sessions in the cwd at startup
      autosave = true, -- whether to autosave loaded sessions before quitting
      autoswitch = {
        enable = false, -- whether to enable autoswitch
        exclude_ft = {}, -- list of filetypes to exclude from autoswitch
      },

      save_hook = nil, -- callback, function to execute before saving a session
      -- useful to update or cleanup global variables for example
      post_hook = nil, -- callback, function to execute after loading a session
      -- useful to restore file trees, file managers or terminals
      -- function()
      --     require('FTerm').open()
      --     require('nvim-tree').toggle(false, true)
      -- end

      fzf_winopts = {
        height = 0.5,
        width = 0.5,
        row = 0.5,
        border = "none",
        preview = {
          horizontal = "top:30%",
        },
      },
    })
  end,
}
