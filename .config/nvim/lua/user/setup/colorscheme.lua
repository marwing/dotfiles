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

        LazyDimmed = { link = 'Comment' },
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
