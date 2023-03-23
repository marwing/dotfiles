local conditions = require('heirline.conditions')

local function build_server_list(opts)
  local names = {}
  local servers = vim.lsp.get_active_clients(opts.buf_only and { bufnr = 0 })

  for _, server in ipairs(servers) do
    if opts.expand_nullls and server.name == 'null-ls' then
      local query = opts.buf_only and { filetype = vim.bo.filetype } or {}
      local sources = require('null-ls').get_source(query)

      for _, source in ipairs(sources) do
        table.insert(names, source.name)
      end
    else
      table.insert(names, server.name)
    end
  end

  if opts.sort then
    table.sort(names)
  end

  return names
end

local function long(opts)
  opts = opts or {}
  local component = {
    update = { 'LspAttach', 'LspDetach' },
  }

  if opts.buf_only then
    table.insert(component.update, 'BufEnter')
  end

  component.provider = function()
    local servers = build_server_list(opts)
    return '[' .. table.concat(servers, ', ') .. ']'
  end

  return component
end

local short = {
  provider = '[LSP]',
}

local lspclients = {
  condition = conditions.lsp_attached,

  flexible = 0,
  long { buf_only = true, expand_nullls = true, sort = true },
  long { buf_only = true, expand_nullls = false, sort = true },
  short,

  on_click = {
    callback = function()
      vim.defer_fn(vim.cmd.LspInfo, 100)
    end,
    name = 'heirline_lsp',
  },
}

return lspclients
