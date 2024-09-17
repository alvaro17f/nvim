return {
  "goolord/alpha-nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },

  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard") -- ["dashboard", "startify"]

    dashboard.section.header.val = {
      [[                                                                          ]],
      [[   .S_SSSs    S.       .S    S.    .S_SSSs     .S_sSSs      sSSs_sSSs     ]],
      [[  .SS~SSSSS   SS.     .SS    SS.  .SS~SSSSS   .SS~YS%%b    d%%SP~YS%%b    ]],
      [[  S%S   SSSS  S%S     S%S    S%S  S%S   SSSS  S%S   `S%b  d%S'     `S%b   ]],
      [[  S%S    S%S  S%S     S%S    S%S  S%S    S%S  S%S    S%S  S%S       S%S   ]],
      [[  S%S SSSS%S  S&S     S&S    S%S  S%S SSSS%S  S%S    d*S  S&S       S&S   ]],
      [[  S&S  SSS%S  S&S     S&S    S&S  S&S  SSS%S  S&S   .S*S  S&S       S&S   ]],
      [[  S&S    S&S  S&S     S&S    S&S  S&S    S&S  S&S_sdSSS   S&S       S&S   ]],
      [[  S&S    S&S  S&S     S&S    S&S  S&S    S&S  S&S~YSY%b   S&S       S&S   ]],
      [[  S*S    S&S  S*b     S*b    S*S  S*S    S&S  S*S   `S%b  S*b       d*S   ]],
      [[  S*S    S*S  S*S.    S*S.   S*S  S*S    S*S  S*S    S%S  S*S.     .S*S   ]],
      [[  S*S    S*S   SSSbs   SSSbs_S*S  S*S    S*S  S*S    S&S   SSSbs_sdSSS    ]],
      [[  SSS    S*S    YSSP    YSSP~SSS  SSS    S*S  S*S    SSS    YSSP~YSSY     ]],
      [[         SP                              SP   SP                          ]],
      [[         Y                               Y    Y                           ]],
      [[                                                                          ]],
    }

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

    dashboard.section.buttons.val = {
      dashboard.button("n", " " .. " New file", ":ene <BAR> startinsert <CR>"),
      dashboard.button("f", " " .. " Find files", ":Telescope find_files <CR>"),
      dashboard.button("g", "󰷾 " .. " Grep text", ":Telescope live_grep <CR>"),
      dashboard.button("r", "󰄉 " .. " Recent files", ":Telescope oldfiles <CR>"),
      dashboard.button("c", " " .. " Config", ":e $MYVIMRC <CR>"),
      dashboard.button("s", " " .. " Restore last session", function()
        require("persistence").load({ last = true })
      end),
      dashboard.button("S", " " .. " Select session to restore", function()
        require("persistence").select()
      end),
      dashboard.button(",", "✓ " .. " Mason", ":Mason<CR>"),
      dashboard.button(".", "󰒲 " .. " Lazy", ":Lazy sync<CR>"),
      dashboard.button("q", " " .. " Quit", ":qa<CR>"),
    }

    alpha.setup(dashboard.opts)
  end,
}
