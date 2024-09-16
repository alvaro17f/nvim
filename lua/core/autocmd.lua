------------------------------------
--AUTO FORMAT ON SAVE
------------------------------------
--vim.cmd([[autocmd BufWritePre * lua vim.lsp.buf.format()]])

------------------------------------
--GOLANG ORGANIZE IMPORTS
------------------------------------
vim.cmd([[autocmd BufWritePre *.go :silent! lua vim.lsp.buf.code_action({ context = { only = { "source.organizeImports" } }, apply = true })]])

------------------------------------
--CURSOR INSERT MODE
------------------------------------
--vim.cmd('autocmd InsertEnter,InsertLeave * set cul!')
