local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

local filetypes = { "javascript", "typescript", "typescriptreact", "javascriptreact" }

local console_debug = s("cdg", {
  t('console.debug("'),
  i(0),
  t('");'),
})

local console_debug_args = s("cdga", {
  t('console.debug("'),
  i(1),
  t('", '),
  i(0),
  t(");"),
})

for _, ft in ipairs(filetypes) do
  ls.add_snippets(ft, {
    console_debug,
    console_debug_args,
  })
end
