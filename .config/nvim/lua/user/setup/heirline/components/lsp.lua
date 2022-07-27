local conditions = require('heirline.conditions')

local lspclients = {
  condition = conditions.lsp_attached,
  update = { 'LspAttach', 'LspDetach' },

  provider = function()
    local names = {}
    for _, server in pairs(vim.lsp.get_active_clients { bufnr = vim.api.nvim_get_current_buf() }) do
      table.insert(names, server.name)
    end
    -- 
    return '[' .. table.concat(names, ', ') .. ']'
  end,
  on_click = {
    callback = function()
      vim.defer_fn(function()
        vim.cmd('LspInfo')
      end, 100)
    end,
    name = 'heirline_lsp',
  },
}

return lspclients
