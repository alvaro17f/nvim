local sources_default = {
  "lazydev",
  "lsp",
  "path",
  "buffer",
  "snippets",
}

if vim.g.ai then
  table.insert(sources_default, "codecompanion")
end

local border = {
  { "╭", "FloatBorder" },
  { "─", "FloatBorder" },
  { "╮", "FloatBorder" },
  { "│", "FloatBorder" },
  { "╯", "FloatBorder" },
  { "─", "FloatBorder" },
  { "╰", "FloatBorder" },
  { "│", "FloatBorder" },
}

return {
  "saghen/blink.cmp",
  event = { "InsertEnter" },
  dependencies = {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp",
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },
  version = "*",
  opts = {
    keymap = {
      preset = "default", -- "default" | "enter" | "super-tab"
      ["<CR>"] = { "accept", "fallback" },
      ["<C-p>"] = { "show", "select_prev", "fallback" },
      ["<C-n>"] = { "show", "select_next", "fallback" },
      ["<C-u>"] = { "scroll_documentation_up", "fallback" },
      ["<C-d>"] = { "scroll_documentation_down", "fallback" },
    },

    appearance = {
      nerd_font_variant = "normal", -- 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
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
      accept = { auto_brackets = { enabled = true } },
      documentation = {
        auto_show = true,
        window = { border = border },
      },
      list = { selection = { preselect = false, auto_insert = false } },
      menu = {
        auto_show = true,
        border = border,
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
      window = { border = border },
    },

    snippets = { preset = "luasnip" },

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

      cmdline = function()
        local type = vim.fn.getcmdtype()
        if type == "/" or type == "?" then
          return { "buffer" }
        end
        if type == ":" then
          return { "cmdline" }
        end
        return {}
      end,
    },
  },

  opts_extend = { "sources.default" },
}
