-- load impatient before every other lua plugin
pcall(require, 'impatient')

require('user.plugins')
require('user.options')
require('user.mappings')
require('user.setup.lsp')
require('user.setup.diagnostic')
require('user.setup.nvim-cmp')
require('user.setup.luasnip')
require('user.setup.telescope')
require('user.setup.notify')
require('user.setup.dressing')
require('user.setup.lualine')
require('user.setup.nvim-treesitter')
require('user.setup.zen-mode')
require('user.setup.twilight')
require('user.setup.gitsigns')
require('user.setup.Comment')
require('user.setup.neo-tree')

require('user.setup.vim-cmake')
require('user.setup.vimtex')
require('user.setup.editorconfig')
require('user.setup.startify')
require('user.setup.markdown-preview')

-- colorscheme
vim.g.gruvbox_italic = true
vim.cmd [[colorscheme gruvbox]]

vim.cmd [[
autocmd FileType markdown set conceallevel=2
]]
