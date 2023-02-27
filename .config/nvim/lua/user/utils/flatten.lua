local function flatten(prefix, current_table, output, sep)
  for k, v in pairs(current_table) do
    vim.validate {
      k = { k, 'string' },
    }

    local next_path = prefix .. k

    if type(v) == 'table' then
      flatten(next_path .. sep, v, output, sep)
    else
      output[next_path] = v
    end
  end
end

---Flattens a nested dictionary into a flat dictionary
---@param t table
---@return table
return function(t, sep)
  sep = sep or '.'

  local output = {}
  flatten('', t, output, sep)
  return output
end
