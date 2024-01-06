return {
  'folke/neodev.nvim',
  dependencies = 'neovim/nvim-lspconfig',
  config = function()
    require('neodev').setup {}
    require('lspconfig').lua_ls.setup(require('user.setup.lsp.utils.overrides').default_params {
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
  end,
}
