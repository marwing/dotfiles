return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
      'windwp/nvim-ts-autotag',
    },
    opts = {
      ensure_installed = {
        -- neovim languages
        'c',
        'lua',
        'vim',
        'vimdoc',
        'query',

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
        'luap',
        'comment',
      },
      auto_install = true,
      highlight = {
        enable = true,
        disable = { 'latex', 'diff', 'gitcommit', 'git_rebase' },
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
    },
    main = 'nvim-treesitter.configs',
    event = { 'VeryLazy', 'BufReadPre' },
  },
  {
    'nvim-treesitter/playground',
    cmd = {
      'TSPlaygroundToggle',
      'TSNodeUnderCursor',
      'TSCaptureUnderCursor',
    },
  },
}
