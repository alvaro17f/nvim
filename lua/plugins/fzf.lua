return {
  {
    "ibhagwan/fzf-lua",
    build = "./install --bin",
    event = "VeryLazy",
    keys = {
      {
        "<leader>ff",
        function()
          if require("utils.git").is_git_repo() then
            return require("fzf-lua").git_files()
          end
          require("fzf-lua").files()
        end,
        desc = "search files",
      },
      {
        "<leader>fg",
        function()
          require("fzf-lua").live_grep_native({ cwd = require("utils.git").get_workspace_root() })
        end,
        desc = "live grep",
      },
      {
        "<leader>fr",
        function()
          require("fzf-lua").oldfiles()
        end,
        desc = "show recent files",
      },
      {
        "<leader>fh",
        function()
          require("fzf-lua").helptags()
        end,
        desc = "show help",
      },
      {
        "<leader>b",
        function()
          require("fzf-lua").buffers()
        end,
        desc = "show buffers",
      },
      {
        "<leader>f<backspace>",
        function()
          require("fzf-lua").resume()
        end,
        desc = "resume fzf",
      },
    },
    config = function()
      local fzf = require("fzf-lua")
      fzf.setup({
        defaults = {
          formatter = "path.filename_first",
        },
        keymap = {
          builtin = {
            ["<c-d>"] = "preview-down",
            ["<c-u>"] = "preview-up",
          },
          fzf = {
            ["ctrl-q"] = "select-all+accept",
          },
        },
      })
      fzf.register_ui_select()
    end,
  },
}
