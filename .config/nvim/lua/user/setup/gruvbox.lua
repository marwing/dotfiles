vim.g.gruvbox_italic = true
vim.cmd([[
colorscheme gruvbox

" overrides for vim.lsp.buf.document_highlight()
highlight! link LspReferenceText CursorLine
highlight! link LspReferenceWrite CursorLine
highlight! link LspReferenceRead CursorLine
]])
