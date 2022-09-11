local lspconfig = require('lspconfig')
local default_params = require('user.setup.lsp.overrides').default_params

local servers = { 'cmake', 'pylsp', 'texlab', 'tsserver' }
for _, server in ipairs(servers) do
  lspconfig[server].setup(default_params)
end

lspconfig.jsonls.setup(default_params {
  settings = {
    json = {
      schemas = require('schemastore').json.schemas(),
      validate = { enable = true },
    },
  },
})

local yaml_schemas = {}
for _, schema in ipairs(require('schemastore').json.schemas()) do
  yaml_schemas[schema.url] = schema.fileMatch
end

lspconfig.yamlls.setup(default_params {
  settings = {
    yaml = {
      schemas = yaml_schemas,
      validate = { enable = true },
    },
  },
})
