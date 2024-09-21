local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

ls.add_snippets("javascript", {
  s("cdg", {
    t("console.debug("),
    i(0),
    t(");"),
  }),
})

ls.add_snippets("typescript", {
  s("cdg", {
    t("console.debug("),
    i(0),
    t(");"),
  }),
})

ls.add_snippets("typescriptreact", {
  s("cdg", {
    t("console.debug("),
    i(0),
    t(");"),
  }),
})

ls.add_snippets("javascriptreact", {
  s("cdg", {
    t("console.debug("),
    i(0),
    t(");"),
  }),
})
