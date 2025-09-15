_G.Utils = _G.Utils or {}
_G.Utils.icons = _G.Utils.icons
  or {
    core = {
      arrows = {
        simple = {
          right = "",
          left = "",
          up = "",
          down = "",
        },
        double = {
          right = "",
          left = "",
          up = "",
          down = "",
        },
      },
      bullet = "●",
      heading = { "󰎤 ", "󰎧 ", "󰎪 ", "󰎭 ", "󰎱 ", "󰎳 " },
      toggle = {
        enabled = " ",
        disabled = " ",
      },
    },

    debugger = {
      stopped = "󰁕 ",
      breakpoint = " ",
      breakpoint_condition = " ",
      breakpoint_rejected = " ",
      log_point = ".>",
    },

    diagnostics = {
      error = " ",
      warn = " ",
      hint = "󰠠 ", -- " "
      info = " ",
    },

    diff = {
      added = " ",
      modified = " ",
      removed = " ",
    },

    gitsigns = {
      v1 = {
        add = "▎",
        change = "▎",
        delete = "",
        topdelete = "",
        changedelete = "▎",
      },
      v2 = {
        add = "+",
        change = "~",
        delete = "_",
        topdelete = "‾",
        changedelete = "~",
      },
    },

    kind = {
      v1 = {
        Array = "  ",
        Boolean = " 󰨙 ",
        Class = " 󰯳 ",
        Codeium = " 󰘦 ",
        Color = " 󰰠 ",
        Control = "  ",
        Collapsed = " > ",
        Constant = " 󰯱 ",
        Constructor = "  ",
        Copilot = "  ",
        Enum = " 󰯹 ",
        EnumMember = "  ",
        Event = "  ",
        Field = "  ",
        File = "  ",
        Folder = "  ",
        Function = " 󰡱 ",
        Interface = " 󰰅 ",
        Key = "  ",
        Keyword = " 󱕴 ",
        Method = " 󰰑 ",
        Module = " 󰆼 ",
        Namespace = " 󰰔 ",
        Null = "  ",
        Number = " 󰰔 ",
        Object = " 󰲟 ",
        Operator = "  ",
        Package = " 󰰚 ",
        Property = " 󰲽 ",
        Reference = " 󰰠 ",
        Snippet = "  ",
        String = "  ",
        Struct = " 󰰣 ",
        TabNine = " 󰏚 ",
        Text = " 󱜥 ",
        TypeParameter = " 󰰦 ",
        Unit = " 󱜥 ",
        Value = "  ",
        Variable = " 󰫧 ",
      },
      v2 = {
        Array = "󰅪",
        Class = "",
        Color = "󰏘",
        Constant = "󰏿",
        Constructor = "",
        Enum = "",
        EnumMember = "",
        Event = "",
        Field = "󰜢",
        File = "󰈙",
        Folder = "󰉋",
        Function = "󰆧",
        Interface = "",
        Keyword = "󰌋",
        Method = "󰆧",
        Module = "",
        Operator = "󰆕",
        Property = "󰜢",
        Reference = "󰈇",
        Snippet = "",
        Struct = "",
        Text = "",
        TypeParameter = "",
        Unit = "",
        Value = "",
        Variable = "󰀫",
      },
    },

    lualine = {
      clock = " ",
      git = {
        branch = "",
        commit = " ",
        logo = " ",
      },
      logo = {
        vim = " ",
        nvim = " ",
      },
      recording = " ",
      separator = {
        component = { left = "", right = "" },
        rounded = { left = "", right = "" },
        section = { left = "", right = "" },
      },
    },

    mason = {
      package_installed = "",
      package_pending = "",
      package_uninstalled = "",
    },

    snacks = {
      dashboard = {
        config = " ",
        file = " ",
        find = " ",
        grep = " ",
        quit = " ",
        recent = " ",
        restore = " ",
        update = " ",
      },
    },
  }
