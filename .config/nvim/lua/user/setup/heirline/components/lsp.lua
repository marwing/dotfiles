local conditions = require('heirline.conditions')

local lspclients = {
  condition = conditions.lsp_attached,
  update = { 'LspAttach', 'LspDetach' },

  provider = function()
    local names = {}
    for _, server in pairs(vim.lsp.get_active_clients()) do
      table.insert(names, server.name)
    end
    -- 
    return '[' .. table.concat(names, ', ') .. ']'
  end,
}

return lspclients
