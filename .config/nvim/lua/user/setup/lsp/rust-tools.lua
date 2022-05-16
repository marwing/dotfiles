require('rust-tools').setup {
  server = {
    on_attach = require('user.setup.lsp.overrides').on_attach,
    capabilities = require('user.setup.lsp.overrides').capabilities,
  },
  tools = {
    hover_with_actions = false,
  },
}
