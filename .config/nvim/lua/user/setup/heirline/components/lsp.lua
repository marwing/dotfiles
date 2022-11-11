local conditions = require('heirline.conditions')

local long = {
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
}

local short = {
  provider = '[LSP]',
}

local lspclients = {
  condition = conditions.lsp_attached,

  flexible = 0,
  long,
  short,

  on_click = {
    callback = function()
      vim.defer_fn(vim.cmd.LspInfo, 100)
    end,
    name = 'heirline_lsp',
  },
}

return lspclients
