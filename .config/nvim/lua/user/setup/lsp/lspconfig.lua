local lspconfig = require('lspconfig')
local default_params = require('user.setup.lsp.overrides').default_params

local servers = { 'cmake', 'jsonls', 'pylsp', 'pyright', 'texlab', 'tsserver' }
for _, server in ipairs(servers) do
  lspconfig[server].setup(default_params)
end
