-- load impatient before every other lua plugin
-- may not be installed yet though
pcall(require, 'impatient')

require('user.mappings')
require('user.options')
require('user.plugins')

require('user.setup.diagnostic')

-- colorscheme
vim.g.gruvbox_italic = true
vim.cmd [[
colorscheme gruvbox

" overrides for vim.lsp.buf.document_highlight()
highlight! link LspReferenceText CursorLine
highlight! link LspReferenceWrite CursorLine
highlight! link LspReferenceRead CursorLine
]]

vim.cmd [[
autocmd FileType markdown set conceallevel=2
]]