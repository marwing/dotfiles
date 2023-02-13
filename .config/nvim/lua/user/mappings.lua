vim.g.mapleader = ' '
vim.g.maplocalleader = ','

-- Shortcutting split navigation:
vim.keymap.set({ 'n', 'v', 't' }, '<A-h>', '<Cmd>wincmd h<CR>')
vim.keymap.set({ 'n', 'v', 't' }, '<A-j>', '<Cmd>wincmd j<CR>')
vim.keymap.set({ 'n', 'v', 't' }, '<A-k>', '<Cmd>wincmd k<CR>')
vim.keymap.set({ 'n', 'v', 't' }, '<A-l>', '<Cmd>wincmd l<CR>')

-- Shortcutting tab navigation
vim.keymap.set('n', '<leader>n', '<cmd>tabprevious<cr>')
vim.keymap.set('n', '<leader>m', '<cmd>tabnext<cr>')

-- escaping from :terminal
vim.keymap.set('t', '<Esc><Esc>', [[<C-\><C-n>]])
