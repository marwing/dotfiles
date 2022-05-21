local function get_clients()
  local clients = vim.lsp.get_active_clients { buffer = 0 }
  local names = {}
  for _, client in ipairs(clients) do
    table.insert(names, client.name)
  end
  return names
end

local function format(list, opts)
  opts = opts or {}
  local sep = opts.sep or ', '
  local pre = opts.pre or '['
  local post = opts.post or ']'

  local res = pre
  for i, item in ipairs(list) do
    local s = i == 1 and '' or sep
    res = res .. s .. tostring(item)
  end
  res = res .. post

  return res
end

return function()
  local clients = get_clients()
  if #clients == 0 then
    return ''
  end
  table.sort(clients)
  return format(clients)
end
