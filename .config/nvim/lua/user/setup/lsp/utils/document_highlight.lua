-- keep track of supported clients attached to buffer
-- this makes it easier to check if any supported clients are available in detach logic
-- without having to go through all active clients and filtering them by buffer and supports_method
local bufs = setmetatable({}, {
  __index = function(table, key)
    table[key] = {}
    return table[key]
  end,
})

local function on_attach(client, bufnr)
  if not client.supports_method('textDocument/documentHighlight') then
    return
  end

  table.insert(bufs[bufnr], client.id)
  if #bufs[bufnr] > 1 then
    -- autocmds are already created for previous client
    return
  end

  local group = vim.api.nvim_create_augroup('lsp_highlight_document_b_' .. tostring(bufnr), { clear = true })

  -- highlight
  vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
    group = group,
    buffer = bufnr,
    callback = vim.lsp.buf.clear_references,
  })
  vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
    group = group,
    buffer = bufnr,
    callback = vim.lsp.buf.document_highlight,
  })

  -- clean up
  vim.api.nvim_create_autocmd('LspDetach', {
    group = group,
    buffer = bufnr,
    callback = function(args)
      table.remove(bufs[args.buf], args.data.client_id)
      if #bufs[args.buf] < 1 then
        vim.api.nvim_del_augroup_by_id(group)
        -- make sure there are no stale highlights sitting in the buffer that would otherwise never be removed
        vim.lsp.buf.clear_references()
      end
    end,
  })
end

return {
  on_attach = on_attach,
}
