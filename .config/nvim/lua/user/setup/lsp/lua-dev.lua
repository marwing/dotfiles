local luadev = require('lua-dev').setup {
  runtime_path = true,
  lspconfig = {
    on_attach = require('user.setup.lsp.overrides').on_attach,
    capabilities = require('user.setup.lsp.overrides').capabilities,
  },
}

require('lspconfig').sumneko_lua.setup(luadev)
