-- disable jobcontrol (suspend) of neovim on <C-z>
vim.keymap.set({ 'n', 'v' }, '<C-z>', '<nop>')

vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_python3_provider = 0

require('user.mappings')
require('user.options')
require('user.plugins')

require('user.diagnostic')
