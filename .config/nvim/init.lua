-- load impatient before every other lua plugin
pcall(require, 'impatient')

require('user.plugins')
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
vim.keymap.set('n', 'cb', '<Plug>(CMakeBuild)')
vim.keymap.set('n', 'cr', '<cmd>CMakeSwitch Release<CR>')
vim.keymap.set('n', 'cd', '<cmd>CMakeSwitch Debug<CR>')
vim.keymap.set('n', 'cq', '<Plug>(CMakeClose)')

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

-- Keep undo history across sessions, by storing in file.
vim.opt.undofile = true

-- set tabwith to 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2

-- automatically expand tabs to spaces
vim.opt.expandtab = true

-- set hybrid line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- spell checking default language
vim.opt.spelllang = 'de_20'

-- more natural splits
vim.opt.splitbelow = true
vim.opt.splitright = true

-- wrap at words, not letters
vim.opt.wrap = true
vim.opt.linebreak = true

vim.opt.showmode = false
vim.opt.clipboard = 'unnamedplus'

vim.opt.signcolumn = 'yes'
vim.opt.cursorline = true

vim.opt.colorcolumn = '+0'

vim.opt.scrolloff = 5

vim.g.list = true

-- enable truecolor support if terminal claims to support it
if vim.env.COLORTERM == "truecolor" then
  vim.opt.termguicolors = true
end

vim.opt.shada:append('r/mnt')
vim.opt.shada:append('r/run/media')

-- How fast some features update (some airline plugins, tagbar, ...)
vim.opt.updatetime = 300

-- colorscheme
vim.g.gruvbox_italic = true
vim.cmd [[colorscheme gruvbox]]

vim.cmd [[
" format JSON using jq
autocmd FileType json map <silent> <A-S-f> :silent %!jq .<CR>

autocmd FileType markdown set conceallevel=2
]]

-- keybindings
vim.g.mapleader = ','

-- Shortcutting split navigation, saving a keypress:
vim.keymap.set({ 'n', 'v' }, '<A-h>', '<C-w>h', { remap = true })
vim.keymap.set({ 'n', 'v' }, '<A-j>', '<C-w>j', { remap = true })
vim.keymap.set({ 'n', 'v' }, '<A-k>', '<C-w>k', { remap = true })
vim.keymap.set({ 'n', 'v' }, '<A-l>', '<C-w>l', { remap = true })

-- Shortcutting tab navigation
vim.keymap.set('n', '<leader>n', '<cmd>tabprevious<cr>')
vim.keymap.set('n', '<leader>m', '<cmd>tabnext<cr>')

vim.keymap.set({ 'n', 'i' }, '<F8>', '<cmd>TagbarToggle<CR>')
