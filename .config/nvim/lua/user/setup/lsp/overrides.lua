return {
  on_attach = function(client, bufnr)
    local function set(key, action, method_or_client)
      if
        not method_or_client
        or (string.match(method_or_client, '%a/%a') and client.supports_method(method_or_client))
        or client.name == method_or_client
      then
        vim.keymap.set('n', key, action, { buffer = bufnr })
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
        filter = function(client)
          return client.name ~= 'sumneko_lua' -- null-ls stylua formats lua code
        end,
      }
    end)
    set('Kk', vim.lsp.buf.code_action, 'textDocument/codeAction')

    set('<space>wa', vim.lsp.buf.add_workspace_folder)
    set('<space>wr', vim.lsp.buf.remove_workspace_folder)
    set('<space>wl', function()
      vim.pretty_print(vim.lsp.buf.list_workspace_folders())
    end)

    -- server extensions
    set('<F12>', '<cmd>ClangdSwitchSourceHeader<CR>', 'clangd')

    -- plugin hooks
    require('user.setup.lsp.document_highlight'):on_attach(client, bufnr)
  end,
  capabilities = (function()
    local capabilities = vim.lsp.protocol.make_client_capabilities()

    if pcall(require, 'cmp_nvim_lsp') then
      capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
    end

    -- TODO: remove this when neovim supports multiple different client offset encodings per buffer
    capabilities.offsetEncoding = { 'utf-16' }

    return capabilities
  end)(),
}
