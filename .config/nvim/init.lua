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

-- vim-cmake
vim.g.cmake_build_dir_location = 'build'
vim.g.cmake_link_compile_commands = 1
vim.g.cmake_generate_options = { '-GNinja' }
vim.g.cmake_statusline = 0

-- vimtex setup
vim.g.tex_flavor = 'latex'
vim.g.vimtex_view_method = 'zathura'
vim.g.vimtex_quickfix_mode = 0
vim.g.vimtex_compiler_latexmk = {
  build_dir = 'dist',
}
vim.cmd [[autocmd FileType tex set textwidth=80]]

-- EditorConfig
vim.g.EditorConfig_exclude_patterns = { 'fugitive://.\\*' }

-- Startify
vim.g.startify_commands = {
  { up = { 'Update Plugins', 'PackerSync' } }
}

vim.g.startify_bookmarks = {
  { c = '~/.config/nvim/init.lua' },
  { g = '~/.config/git/ignore' },
}

-- markdown-preview
vim.g.mkdp_page_title = '${name}'

-- colorscheme
vim.g.gruvbox_italic = true
vim.cmd [[colorscheme gruvbox]]

vim.cmd [[
" format JSON using jq
autocmd FileType json map <silent> <A-S-f> :silent %!jq .<CR>

autocmd FileType markdown set conceallevel=2
]]
