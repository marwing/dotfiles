vim.g.mapleader = ' '
vim.g.maplocalleader = ','

-- Shortcutting split navigation:
vim.keymap.set({ 'n', 'v' }, '<A-h>', '<C-w>h')
vim.keymap.set({ 'n', 'v' }, '<A-j>', '<C-w>j')
vim.keymap.set({ 'n', 'v' }, '<A-k>', '<C-w>k')
vim.keymap.set({ 'n', 'v' }, '<A-l>', '<C-w>l')

-- Shortcutting tab navigation
vim.keymap.set('n', '<leader>n', '<cmd>tabprevious<cr>')
vim.keymap.set('n', '<leader>m', '<cmd>tabnext<cr>')

-- escaping from :terminal
vim.keymap.set('t', '<Esc><Esc>', [[<C-\><C-n>]])

---------------- Plugins ----------------
-- tagbar
vim.keymap.set('n', '<leader>o', '<cmd>TagbarToggle<CR>')
