return {
  'p00f/clangd_extensions.nvim',
  dependencies = {
    'neovim/nvim-lspconfig',
    opts = {
      clangd = {
        cmd = {
          'clangd',
          '-query-driver=/usr/**/arm-none-eabi*',
          '--completion-style=detailed',
          '--malloc-trim',
          '--enable-config',
          '--use-dirty-headers',
        },
      },
    },
  },
}
