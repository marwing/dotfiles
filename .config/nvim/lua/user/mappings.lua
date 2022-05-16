vim.g.mapleader = ','

-- Shortcutting split navigation:
vim.keymap.set({ 'n', 'v' }, '<A-h>', '<C-w>h')
vim.keymap.set({ 'n', 'v' }, '<A-j>', '<C-w>j')
vim.keymap.set({ 'n', 'v' }, '<A-k>', '<C-w>k')
vim.keymap.set({ 'n', 'v' }, '<A-l>', '<C-w>l')

-- Shortcutting tab navigation
vim.keymap.set('n', '<leader>n', '<cmd>tabprevious<cr>')
vim.keymap.set('n', '<leader>m', '<cmd>tabnext<cr>')

---------------- Plugins ----------------
-- tagbar
vim.keymap.set({ 'n', 'i' }, '<F8>', '<cmd>TagbarToggle<CR>')
