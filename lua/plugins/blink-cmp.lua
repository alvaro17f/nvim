local sources_default = {
  "lazydev",
  "lsp",
  "path",
  "snippets",
  "buffer",
}

return {
  "saghen/blink.cmp",
  version = "*",
  event = { "InsertEnter" },
  dependencies = { "rafamadriz/friendly-snippets" },
  opts = {
    keymap = {
      preset = "default", -- "default" | "enter" | "super-tab"
      ["<CR>"] = { "accept", "fallback" },
      ["<C-p>"] = { "show", "select_prev", "fallback" },
      ["<C-n>"] = { "show", "select_next", "fallback" },
      ["<C-u>"] = { "scroll_documentation_up", "fallback" },
      ["<C-d>"] = { "scroll_documentation_down", "fallback" },
      ["<Tab>"] = {},
      ["<S-Tab>"] = {},
    },

    appearance = {
      nerd_font_variant = "mono",
      kind_icons = {
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
    },

    completion = {
      accept = {
        auto_brackets = {
          enabled = true,
        },
      },
      documentation = {
        auto_show = true,
      },
      list = {
        selection = {
          preselect = false,
          auto_insert = false,
        },
      },
      menu = {
        auto_show = true,
        draw = {
          columns = {
            { "kind_icon" },
            { "label", "label_description", gap = 1 },
            { "source_name" },
          },
          treesitter = { "lsp" },
        },
      },
    },

    signature = {
      enabled = true,
    },

    sources = {
      default = sources_default,

      providers = {
        lazydev = {
          name = "lazydev",
          module = "lazydev.integrations.blink",
        },
        lsp = {
          name = "lsp",
          module = "blink.cmp.sources.lsp",
          fallbacks = { "buffer" },
        },
        path = {
          name = "path",
          module = "blink.cmp.sources.path",
          fallbacks = { "buffer", "snippets", "luasnip" },
        },
        buffer = {
          name = "buffer",
          module = "blink.cmp.sources.buffer",
        },
        snippets = {
          name = "snippets",
          module = "blink.cmp.sources.snippets",
        },
      },
    },
  },

  opts_extend = { "sources.default" },
}
