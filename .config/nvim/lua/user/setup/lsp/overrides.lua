return {
  on_attach = function(client, bufnr)
    local opts = { buffer = bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)

    vim.keymap.set('n', 'KK', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)

    vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<A-S-f>', vim.lsp.buf.formatting, opts)
    vim.keymap.set('n', 'Kk', vim.lsp.buf.code_action, opts)

    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function() vim.pretty_print(vim.lsp.buf.list_workspace_folders()) end, opts)

    if client.name == 'clangd' then
      vim.keymap.set('n', '<F12>', '<cmd>ClangdSwitchSourceHeader<CR>', opts)
    end

    require('user.setup.lsp.document_highlight')(client)
  end,
  capabilities = (function()
    local capabilities = vim.lsp.protocol.make_client_capabilities()

    if pcall(require, 'cmp_nvim_lsp') then
      capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
    end

    return capabilities
  end)(),
}
