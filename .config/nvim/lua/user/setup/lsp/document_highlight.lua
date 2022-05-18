return function(client)
  if client.resolved_capabilities.document_highlight then
    local group = vim.api.nvim_create_augroup("lsp_highlight_document", { clear = true })
    vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
      group = group,
      buffer = 0,
      callback = function()
        vim.lsp.buf.clear_references()
      end,
    })
    vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
      group = group,
      buffer = 0,
      callback = function()
        vim.lsp.buf.document_highlight()
      end,
    })
  end
end
