return {
  "sudo-tee/opencode.nvim",
  lazy = false,
  priority = 1000,
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    require("opencode").setup({
      prefered_picker = nil, -- 'telescope', 'fzf', 'mini.pick', 'snacks', if nil, it will use the best available picker
      default_global_keymaps = true, -- If false, disables all default global keymaps
      default_mode = "plan", -- 'build' or 'plan' or any custom configured. @see [OpenCode Modes](https://opencode.ai/docs/modes/)
      config_file_path = nil, -- Path to opencode configuration file if different from the default `~/.config/opencode/config.json` or `~/.config/opencode/opencode.json`
      keymap = {
        global = {
          toggle = "<leader>oa", -- Open opencode. Close if opened
          open_input = "<leader>oi", -- Opens and focuses on input window on insert mode
          open_input_new_session = "<leader>oI", -- Opens and focuses on input window on insert mode. Creates a new session
          open_output = "<leader>oo", -- Opens and focuses on output window
          toggle_focus = "<leader>ot", -- Toggle focus between opencode and last window
          close = "<leader>oq", -- Close UI windows
          toggle_fullscreen = "<leader>of", -- Toggle between normal and fullscreen mode
          select_session = "<leader>os", -- Select and load a opencode session
          configure_provider = "<leader>op", -- Quick provider and model switch from predefined list
          diff_open = "<leader>od", -- Opens a diff tab of a modified file since the last opencode prompt
          diff_next = "<leader>o]", -- Navigate to next file diff
          diff_prev = "<leader>o[", -- Navigate to previous file diff
          diff_close = "<leader>oc", -- Close diff view tab and return to normal editing
          diff_revert_all_last_prompt = "<leader>ora", -- Revert all file changes since the last opencode prompt
          diff_revert_this_last_prompt = "<leader>ort", -- Revert current file changes since the last opencode prompt
          diff_revert_all = "<leader>orA", -- Revert all file changes since the last opencode session
          diff_revert_this = "<leader>orT", -- Revert current file changes since the last opencode session
        },
        window = {
          submit = "<cr>", -- Submit prompt (normal mode)
          submit_insert = "<C-s>", -- Submit prompt (insert mode)
          close = "<esc>", -- Close UI windows
          stop = "<C-c>", -- Stop opencode while it is running
          next_message = "]]", -- Navigate to next message in the conversation
          prev_message = "[[", -- Navigate to previous message in the conversation
          mention_file = "@", -- Pick a file and add to context. See File Mentions section
          toggle_pane = "<tab>", -- Toggle between input and output panes
          prev_prompt_history = "<up>", -- Navigate to previous prompt in history
          next_prompt_history = "<down>", -- Navigate to next prompt in history
          switch_mode = "<M-m>", -- Switch between modes (build/plan)
          focus_input = "<C-i>", -- Focus on input window and enter insert mode at the end of the input from the output window
          debug_messages = "<leader>oD", -- Open raw message in new buffer for debugging
          debug_output = "<leader>oO", -- Open raw output in new buffer for debugging
        },
      },
      ui = {
        floating = false, -- Use floating windows for input and output
        window_width = 0.40, -- Width as percentage of editor width
        input_height = 0.15, -- Input height as percentage of window height
        fullscreen = false, -- Start in fullscreen mode (default: false)
        layout = "right", -- Options: "center" or "right"
        floating_height = 0.8, -- Height as percentage of editor height for "center" layout
        display_model = true, -- Display model name on top winbar
        window_highlight = "Normal:OpencodeBackground,FloatBorder:OpencodeBorder", -- Highlight group for the opencode window
        output = {
          tools = {
            show_output = true, -- Show tools output [diffs, cmd output, etc.] (default: true)
          },
        },
      },
      context = {
        cursor_data = true, -- send cursor position and current line to opencode
        diagnostics = {
          info = false, -- Include diagnostics info in the context (default to false
          warn = false, -- Include diagnostics warnings in the context
          error = true, -- Include diagnostics errors in the context
        },
      },
      debug = {
        enabled = false, -- Enable debug messages in the output window
      },
    })
  end,
}
