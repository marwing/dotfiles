-- load impatient before every other lua plugin
-- may not be installed yet though
pcall(require, 'impatient')

-- disable jobcontrol (suspend) of neovim on <C-z>
vim.keymap.set({ 'n', 'v' }, '<C-z>', '<nop>')

require('user.mappings')
require('user.options')
require('user.plugins')

require('user.setup.diagnostic')
