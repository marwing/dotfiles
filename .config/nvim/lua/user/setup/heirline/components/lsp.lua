local conditions = require('heirline.conditions')

local lspclients = {
  condition = conditions.lsp_attached,
  update = { 'LspAttach', 'LspDetach' },

  provider = function()
    local names = {}
    -- TODO: Retry {bufnr = 0}, requires new update autocmd (e.g. BufSwitched)
    local servers = vim.lsp.get_active_clients()
    for _, server in ipairs(servers) do
      table.insert(names, server.name)
    end
    return '[' .. table.concat(names, ', ') .. ']'
  end,

  on_click = {
    callback = function()
      vim.defer_fn(function()
        vim.cmd.LspInfo()
      end, 100)
    end,
    name = 'heirline_lsp',
  },
}

return lspclients
