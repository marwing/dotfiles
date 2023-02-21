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
    config = function()
      require('gruvbox').setup {
        overrides = {
          DiagnosticFloatingWarn = { link = 'DiagnosticWarn' },
          Directory = { link = 'GruvboxGreenBold' },
          String = { italic = false },
          Operator = { italic = false },
          ['@variable'] = { link = 'Identifier' },

          -- overrides for vim.lsp.buf.document_highlight()
          LspReferenceText = { link = 'CursorLine' },
          LspReferenceWrite = { link = 'CursorLine' },
          LspReferenceRead = { link = 'CursorLine' },
        },
      }
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
