-- slightly modified from
-- https://github.com/b0o/SchemaStore.nvim/pull/10/files#diff-aeab26203d2103a80a94a9089ae766cfa9905df45f3fbb343928b31b54a53219R94-R102
local function yaml_schemas(opts)
  local schemas = {}
  vim.tbl_map(function(schema)
    schemas[schema.url] = schema.fileMatch
  end, require('schemastore').json.schemas(opts))
  return schemas
end

local function config()
  local lspconfig = require('lspconfig')
  local default_params = require('user.setup.lsp.utils.overrides').default_params

  local servers = { 'cmake', 'ltex', 'pylsp', 'texlab', 'tsserver', 'vimls' }
  for _, server in ipairs(servers) do
    lspconfig[server].setup(default_params)
  end

  lspconfig.jsonls.setup(default_params {
    on_new_config = function(new_config)
      new_config.settings.json.schemas = new_config.settings.json.schemas or {}
      vim.list_extend(new_config.settings.json.schemas, require('schemastore').json.schemas())
    end,
    settings = {
      json = {
        validate = { enable = true },
      },
    },
  })

  lspconfig.yamlls.setup(default_params {
    on_new_config = function(new_config)
      new_config.settings.yaml.schemas =
        vim.tbl_deep_extend('keep', new_config.settings.yaml.schemas or {}, yaml_schemas())
    end,
    settings = {
      yaml = {
        validate = { enable = true },
      },
    },
  })
end

return {
  {
    'neovim/nvim-lspconfig',
    config = config,
    event = { 'VeryLazy', 'BufReadPre' },
  },
  {
    'b0o/schemastore.nvim',
    lazy = true,
  },
}
