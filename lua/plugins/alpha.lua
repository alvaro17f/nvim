return {
  "goolord/alpha-nvim",
  dependencies = {
    "echasnovski/mini.icons",
  },

  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard") -- ["dashboard", "startify"]

    dashboard.section.header.val = {
      [[                                                                       ]],
      [[                                                                     ]],
      [[       ████ ██████           █████      ██                     ]],
      [[      ███████████             █████                             ]],
      [[      █████████ ███████████████████ ███   ███████████   ]],
      [[     █████████  ███    █████████████ █████ ██████████████   ]],
      [[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
      [[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
      [[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
      [[                                                                       ]],
      [[                                                                       ]],
      [[                                                                       ]],
    }

    dashboard.section.header.val = {
      [[        .---.        .----------- ]],
      [[       /     \  __  /    ------   ]],
      [[      / /     \(  )/    -----     ]],
      [[     //////   ' \/ `   ---        ]],
      [[    //// / // :    : ---          ]],
      [[   // /   /  /`    '--            ]],
      [[  //          //..\\              ]],
      [[         ====UU====UU====         ]],
      [[             '//||\\`             ]],
      [[               ''``               ]],
      [[           memento mori           ]],
    }

    dashboard.section.buttons.val = {
      dashboard.button("n", " " .. " New file", ":ene <BAR> startinsert <CR>"),
      dashboard.button("<leader>ff", " " .. " Find files", ":Telescope find_files <CR>"),
      dashboard.button("<leader>fg", "󰷾 " .. " Grep text", ":Telescope live_grep <CR>"),
      dashboard.button("<leader>fr", "󰄉 " .. " Recent files", ":Telescope oldfiles <CR>"),
      dashboard.button("<leader>cc", " " .. " Config", ":e $MYVIMRC <CR>"),
      dashboard.button("<leader>ww", " " .. " Select session to restore", ":SessionSearch<CR>"),
      dashboard.button("<leader>,", "✓ " .. " Mason", ":Mason<CR>"),
      dashboard.button("<leader>.", "󰒲 " .. " Lazy", ":Lazy sync<CR>"),
      dashboard.button("q", " " .. " Quit", ":qa<CR>"),
    }

    alpha.setup(dashboard.opts)

    -- Open alpha dashboard when no buffers
    vim.api.nvim_create_autocmd("User", {
      pattern = "BDeletePost*",
      callback = function(event)
        local fallback_name = vim.api.nvim_buf_get_name(event.buf)
        local fallback_ft = vim.api.nvim_buf_get_option(event.buf, "filetype")
        local fallback_on_empty = fallback_name == "" and fallback_ft == ""

        if fallback_on_empty then
          vim.cmd("Alpha")
        end
      end,
    })
  end,
}
