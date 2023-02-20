local function disable_for(clients)
  return function(client)
    return not vim.tbl_contains(clients, client.name)
  end
end

local overrides = {
  on_attach = function(client, bufnr)
    local function set(key, action, method_or_client, modes)
      if
        not method_or_client
        or (string.match(method_or_client, '%a/%a') and client.supports_method(method_or_client))
        or client.name == method_or_client
      then
        vim.keymap.set(modes or 'n', key, action, { buffer = bufnr })
      end
    end

    set('gD', vim.lsp.buf.declaration, 'textDocument/declaration')
    set('gd', vim.lsp.buf.definition, 'textDocument/definition')
    set('gt', vim.lsp.buf.type_definition)
    set('gi', vim.lsp.buf.implementation)
    set('gr', vim.lsp.buf.references)

    set('KK', vim.lsp.buf.hover, 'textDocument/hover')
    set('<C-k>', vim.lsp.buf.signature_help)

    set('<F2>', vim.lsp.buf.rename)
    set('<A-S-f>', function()
      vim.lsp.buf.format {
        filter = disable_for { 'lua_ls', 'texlab' },
      }
    end, nil, { 'n', 'v' })
    set('Kk', vim.lsp.buf.code_action, 'textDocument/codeAction', { 'n', 'v' })

    set('<space>wa', vim.lsp.buf.add_workspace_folder)
    set('<space>wr', vim.lsp.buf.remove_workspace_folder)
    set('<space>wl', function()
      vim.pretty_print(vim.lsp.buf.list_workspace_folders())
    end)

    -- server extensions
    set('<F12>', '<cmd>ClangdSwitchSourceHeader<CR>', 'clangd')

    -- plugin hooks
    require('user.setup.lsp.document_highlight').on_attach(client, bufnr)

    if client.supports_method('textDocument/documentSymbol') then
      require('nvim-navic').attach(client, bufnr)
    end

    if client.name == 'jdtls' then
      require('jdtls.setup').add_commands()
    end
  end,
  capabilities = (function()
    local capabilities = vim.lsp.protocol.make_client_capabilities()

    if pcall(require, 'cmp_nvim_lsp') then
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())
    end

    -- TODO: remove this when neovim supports multiple different client offset encodings per buffer
    capabilities.offsetEncoding = { 'utf-16' }

    return capabilities
  end)(),
}

overrides.default_params = setmetatable({
  on_attach = overrides.on_attach,
  capabilities = overrides.capabilities,
}, {
  __call = function(table, opts)
    return vim.tbl_deep_extend('force', table, opts or {})
  end,
})

return overrides
