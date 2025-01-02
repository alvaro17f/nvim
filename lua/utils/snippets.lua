local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

local filetypes = { "javascript", "typescript", "typescriptreact", "javascriptreact" }

local console_debug = s("cdg", {
  t('console.debug("'),
  i(1),
  t('");'),
  i(2),
})

local console_debug_args = s("cdga", {
  t('console.debug("'),
  i(1),
  t('", '),
  i(2),
  t(");"),
  i(3),
})

local console_log = s("clg", {
  t('console.log("'),
  i(1),
  t('");'),
  i(2),
})

local console_log_args = s("clga", {
  t('console.log("'),
  i(1),
  t('", '),
  i(2),
  t(");"),
  i(3),
})

for _, ft in ipairs(filetypes) do
  ls.add_snippets(ft, {
    console_debug,
    console_debug_args,
    console_log,
    console_log_args,
  })
end
