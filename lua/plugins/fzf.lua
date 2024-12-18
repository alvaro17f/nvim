return {
  {
    "ibhagwan/fzf-lua",
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
          require("fzf-lua").live_grep({ cwd = require("utils.git").get_workspace_root() })
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
        hls = { normal = "Pmenu" },
        winopts = {
          height = 0.5,
          width = 0.8,
          row = 0.5,
          border = "none",
        },
        fzf_opts = {
          ["--no-info"] = "",
          ["--info"] = "hidden",
          ["--padding"] = "13%,5%,13%,5%",
          ["--header"] = " ",
          ["--no-scrollbar"] = "",
        },
        defaults = {
          formatter = "path.filename_first",
        },
        buffers = {
          prompt = "buffers: ",
          preview_opts = "hidden",
          no_header = true,
          fzf_opts = { ["--delimiter"] = " ", ["--with-nth"] = "-1.." },
        },
        helptags = {
          prompt = "💡:",
          winopts = {
            width = 0.8,
            height = 0.7,
            preview = {
              layout = "horizontal",
              horizontal = "up:75%",
            },
          },
        },
        lsp = {
          code_actions = {
            prompt = "code actions:",
            winopts = {
              width = 0.8,
              height = 0.7,
              preview = {
                layout = "horizontal",
                horizontal = "up:75%",
              },
            },
          },
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
