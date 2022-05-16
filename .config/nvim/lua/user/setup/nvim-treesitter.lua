require('nvim-treesitter.configs').setup {
  ensure_installed = 'all',
  highlight = {
    enable = true,
    disable = { 'cmake', 'vim', 'latex' },
    additional_vim_regex_highlighting = false,
  },
}
