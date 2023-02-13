return {
  'p00f/clangd_extensions.nvim',
  dependencies = 'neovim/nvim-lspconfig',
  config = function()
    require('clangd_extensions').setup {
      server = require('user.setup.lsp.utils.overrides').default_params {
        cmd = {
          'clangd',
          '-query-driver=/usr/**/arm-none-eabi*',
          '--completion-style=detailed',
          '--malloc-trim',
          '--enable-config',
          '--use-dirty-headers',
          '--include-cleaner-stdlib',
        },
      },
      extensions = {
        autoSetHints = false,
      },
    }
  end,
  ft = { 'c', 'cpp' },
}
