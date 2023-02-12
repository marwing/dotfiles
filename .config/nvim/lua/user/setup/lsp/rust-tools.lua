require('rust-tools').setup {
  server = require('user.setup.lsp.overrides').default_params {
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
