local lspconfig = require('lspconfig')

local on_attach = require('user.setup.lsp.overrides').on_attach
local capabilities = require('user.setup.lsp.overrides').capabilities

local servers = { 'cmake', 'jsonls', 'pylsp', 'pyright', 'texlab', 'tsserver' }
for _, server in ipairs(servers) do
  lspconfig[server].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end
