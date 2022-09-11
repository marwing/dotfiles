require('rust-tools').setup {
  server = require('user.setup.lsp.overrides').default_params,
  tools = {
    hover_with_actions = false,
  },
}
