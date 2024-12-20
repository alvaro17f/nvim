return {
  "saghen/blink.cmp",
  lazy = false,
  dependencies = {
    { "L3MON4D3/LuaSnip", version = "v2.*" },
    "rafamadriz/friendly-snippets",
  },
  version = "v0.*",
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
      use_nvim_cmp_as_default = true, -- Fallback highlight groups to nvim-cmp's highlight groups
      nerd_font_variant = "mono", -- 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
    },

    completion = {
      accept = { auto_brackets = { enabled = true } }, -- Experimental auto-brackets support
      documentation = { auto_show = true },
      list = { selection = "manual" },
      menu = { auto_show = true },
    },

    signature = { enabled = true }, -- Experimental signature help support

    snippets = {
      expand = function(snippet)
        require("luasnip").lsp_expand(snippet)
      end,
      active = function(filter)
        if filter and filter.direction then
          return require("luasnip").jumpable(filter.direction)
        end
        return require("luasnip").in_snippet()
      end,
      jump = function(direction)
        require("luasnip").jump(direction)
      end,
    },

    sources = {
      default = {
        "lazydev",
        "lsp",
        "path",
        "luasnip",
        "snippets",
        "buffer",
      },
      providers = {
        lazydev = { name = "LazyDev", module = "lazydev.integrations.blink", score_offset = 100 },
      },
    },
  },

  opts_extend = { "sources.default" },
}
