require('nvim-treesitter.configs').setup {
  ensure_installed = {
    -- neovim languages
    'c',
    'lua',
    'vim',
    'help',

    -- other languages I use regularly
    'bash',
    'cmake',
    'cpp',
    'python',

    -- markup
    'latex',
    'bibtex',
    'markdown',
    'markdown_inline',

    -- data formats
    'json',
    'toml',
    'yaml',

    -- injection only
    'regex',
    'comment',
  },
  auto_install = true,
  highlight = {
    enable = true,
    disable = { 'latex', 'diff' },
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
