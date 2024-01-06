local M = {}

local attach_augroup = vim.api.nvim_create_augroup('user_utils_lsp_attach', { clear = true })

M.on_attach = function(cb)
  vim.api.nvim_create_autocmd('LspAttach', {
    group = attach_augroup,
    callback = function(args)
      local bufnr = args.buf
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      cb(client, bufnr)
    end,
  })
end

return M
