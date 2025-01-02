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
      ["<Tab>"] = nil,
      ["<S-Tab>"] = nil,
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
      accept = { auto_brackets = { enabled = true } },
      documentation = { auto_show = true },
      list = { selection = "manual" },
      menu = { auto_show = true },
    },

    signature = { enabled = true },

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
        "buffer",
        "luasnip",
      },

      providers = {
        lazydev = {
          name = "lazydev",
          module = "lazydev.integrations.blink",
          score_offset = 100,
        },
        lsp = {
          name = "lsp",
          module = "blink.cmp.sources.lsp",
          score_offset = 90,
        },
        path = {
          name = "path",
          module = "blink.cmp.sources.path",
          fallbacks = { "luasnip", "buffer" },
        },
        buffer = {
          name = "buffer",
          module = "blink.cmp.sources.buffer",
        },
        luasnip = {
          name = "luasnip",
          module = "blink.cmp.sources.luasnip",
          score_offset = 80,
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
