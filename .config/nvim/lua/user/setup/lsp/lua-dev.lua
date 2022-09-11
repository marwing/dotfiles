local luadev = require('lua-dev').setup {
  runtime_path = true,
  lspconfig = require('user.setup.lsp.overrides').default_params,
}

require('lspconfig').sumneko_lua.setup(luadev)
