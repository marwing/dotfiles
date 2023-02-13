local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
 -- stylua: ignore
  vim.fn.system { 'git', 'clone', '--filter=blob:none', 'https://github.com/folke/lazy.nvim.git', '--branch=stable', lazypath }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup('user.setup', {
  dev = {
    path = '~/Workspace/vim',
  },
  install = {
    colorscheme = { 'gruvbox', 'habamax' },
  },
})

vim.keymap.set('n', '<leader>l', '<cmd>Lazy<CR>')
