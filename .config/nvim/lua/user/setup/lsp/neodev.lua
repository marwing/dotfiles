require('neodev').setup {}
require('lspconfig').lua_ls.setup(require('user.setup.lsp.overrides').default_params {
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
