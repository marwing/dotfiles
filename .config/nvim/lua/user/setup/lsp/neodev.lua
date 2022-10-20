require('neodev').setup {}
require('lspconfig').sumneko_lua.setup(require('user.setup.lsp.overrides').default_params {
  settings = {
    Lua = {
      completion = {
        callSnippet = 'Replace',
      },
      telemetry = {
        enable = false,
      },
    },
  },
})
