require('lua-dev').setup {}
require('lspconfig').sumneko_lua.setup(require('user.setup.lsp.overrides').default_params)
