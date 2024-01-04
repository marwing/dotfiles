return {
  -- {
  --   'gruvbox-community/gruvbox',
  --   priority = 1000,
  --   config = function()
  --     vim.cmd.colorscheme('gruvbox')
  --   end,
  -- },
  {
    'ellisonleao/gruvbox.nvim',
    priority = 1000,
    opts = {
      italic = {
        strings = false,
      },
      overrides = {
        DiagnosticFloatingWarn = { link = 'DiagnosticWarn' },
        Directory = { link = 'GruvboxGreenBold' },
        ['@variable'] = { link = 'Identifier' },

        -- overrides for vim.lsp.buf.document_highlight()
        LspReferenceText = { link = 'CursorLine' },
        LspReferenceWrite = { link = 'CursorLine' },
        LspReferenceRead = { link = 'CursorLine' },

        DiffDelete = { fg = 'NONE', bg = '#431313', reverse = false },
        DiffAdd = { fg = 'NONE', bg = '#142a03', reverse = false },
        DiffChange = { fg = 'NONE', bg = '#3b3307', reverse = false },
        DiffText = { fg = 'NONE', bg = '#4d520d', reverse = false },

        GitSignsAdd = { link = 'GruvboxGreenSign' },
        GitSignsChange = { link = 'GruvboxAquaSign' },
        GitSignsDelete = { link = 'GruvboxRedSign' },

        LazyDimmed = { link = 'Comment' },

        -- From https://github.com/mars90226/dotvim/commit/33e0c531f33264765b5bc82eda33b9fb91837466
        -- Fix Vim's default highlight group linking
        -- Ref: https://github.com/neovim/neovim/issues/26378
        -- Ref: https://github.com/ellisonleao/gruvbox.nvim/issues/307
        ['@punctuation.bracket'] = { link = 'Special' },
        ['@punctuation.delimiter'] = { link = 'Special' },
        ['@punctuation.special'] = { link = 'Special' },
      },
    },
    config = function(_, opts)
      require('gruvbox').setup(opts)
      vim.cmd.colorscheme('gruvbox')
    end,
  },
  {
    'folke/tokyonight.nvim',
    opts = {
      style = 'moon',
      sidebars = {
        'help',
        'qf',
        'tagbar',
      },
    },
    lazy = true,
  },
}
