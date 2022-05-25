require('nvim-treesitter.configs').setup {
  ensure_installed = 'all',
  highlight = {
    enable = true,
    disable = { 'cmake', 'vim', 'latex' },
    additional_vim_regex_highlighting = false,
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ['<leader>sa'] = '@parameter.inner',
        ['<leader>sf'] = '@function.outer',
      },
      swap_previous = {
        ['<leader>sA'] = '@parameter.inner',
        ['<leader>sF'] = '@function.outer',
      },
    },
  },
  autotag = {
    enable = true,
  },
}
