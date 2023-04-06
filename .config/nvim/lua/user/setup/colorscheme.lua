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
      local colors = require('gruvbox.palette').get_base_colors()
      require('gruvbox').setup {
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

          DiffDelete = { fg = 'NONE', bg = colors.subtle_red, reverse = false },
          DiffAdd = { fg = 'NONE', bg = colors.subtle_green, reverse = false },
          DiffChange = { fg = 'NONE', bg = colors.subtle_brown, reverse = false },
          DiffText = { fg = 'NONE', bg = colors.subtle_yellow, reverse = false },

          LazyDimmed = { link = 'Comment' },
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
