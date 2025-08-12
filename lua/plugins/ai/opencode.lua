return {
  "NickvanDyke/opencode.nvim",
  opts = {
    terminal = {
      win = {
        enter = true,
      },
    },
  },
  -- stylua: ignore
  keys = {
    { '<C-/>',      function() require('opencode').toggle() end, desc = 'Toggle embedded opencode', mode = { 'n', 't' }, },
    { '<leader>oa', function() require('opencode').ask() end, desc = 'Ask opencode', mode = 'n', },
    { '<leader>oa', function() require('opencode').ask('@selection: ') end, desc = 'Ask opencode about selection', mode = 'v', },
    { '<leader>ob', function() require('opencode').ask('@buffer: ') end, desc = 'Ask opencode about current buffer', mode = 'n', },
    { '<leader>oc', function() require('opencode').ask('@cursor: ') end, desc = 'Ask opencode about current cursor', mode = 'n', },
    { '<leader>op', function() require('opencode').select_prompt() end, desc = 'Select prompt', mode = { 'n', 'v', }, },
    { '<leader>on', function() require('opencode').command('session_new') end, desc = 'New session', },
    { '<leader>oy', function() require('opencode').command('messages_copy') end, desc = 'Copy last message', },
    { '<S-C-u>',    function() require('opencode').command('messages_half_page_up') end, desc = 'Scroll messages up', mode = 't' },
    { '<S-C-d>',    function() require('opencode').command('messages_half_page_down') end, desc = 'Scroll messages down', mode = 't' },
  },
}
