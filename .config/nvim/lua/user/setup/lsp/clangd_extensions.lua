require('clangd_extensions').setup {
  server = {
    cmd = {
      'clangd',
      '-query-driver=/usr/**/arm-none-eabi*',
      '--completion-style=detailed',
      '--malloc-trim',
      '--enable-config',
      '--use-dirty-headers',
    },
    on_attach = require('user.setup.lsp.overrides').on_attach,
    capabilities = require('user.setup.lsp.overrides').capabilities,
  },
  extensions = {
    autoSetHints = false,
  },
}
