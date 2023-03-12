return {
  {
    'neovim/nvim-lspconfig',
    opts = {
      cmake = {},
      ltex = {},
      pylsp = {},
      texlab = {},
      tsserver = {},
      vimls = {},
      jsonls = {
        on_new_config = function(new_config)
          new_config.settings.json.schemas = new_config.settings.json.schemas or {}
          vim.list_extend(new_config.settings.json.schemas, require('schemastore').json.schemas())
        end,
        settings = {
          json = {
            validate = { enable = true },
          },
        },
      },
      yamlls = {
        on_new_config = function(new_config)
          new_config.settings.yaml.schemas = new_config.settings.yaml.schemas or {}
          vim.list_extend(new_config.settings.yaml.schemas, require('schemastore').yaml.schemas())
        end,
        settings = {
          yaml = {
            validate = { enable = true },
          },
        },
      },
    },
    config = function(_, opts)
      local default_params = require('user.setup.lsp.utils.overrides').default_params

      for server, config in pairs(opts) do
        vim.validate {
          server = { server, 'string' },
          config = { config, 'table' },
        }

        require('lspconfig')[server].setup(default_params(config))
      end
    end,
    event = { 'VeryLazy', 'BufReadPre' },
  },
  {
    'b0o/schemastore.nvim',
    lazy = true,
  },
}
