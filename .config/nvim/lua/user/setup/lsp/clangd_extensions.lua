require('clangd_extensions').setup {
  server = require('user.setup.lsp.overrides').default_params {
    cmd = {
      'clangd',
      '-query-driver=/usr/**/arm-none-eabi*',
      '--completion-style=detailed',
      '--malloc-trim',
      '--enable-config',
      '--use-dirty-headers',
    },
  },
  extensions = {
    autoSetHints = false,
  },
}
