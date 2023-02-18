return {
  'simrat39/rust-tools.nvim',
  dependencies = 'neovim/nvim-lspconfig',
  config = function()
    require('rust-tools').setup {
      server = require('user.setup.lsp.utils.overrides').default_params {
        settings = {
          ['rust-analyzer'] = {
            checkOnSave = {
              command = 'clippy',
            },
            semanticHighlighting = {
              strings = {
                -- This overwrites treesitter injections (regex, etc)
                enable = false,
              },
            },
          },
        },
      },
    }
  end,
  ft = 'rust',
}
