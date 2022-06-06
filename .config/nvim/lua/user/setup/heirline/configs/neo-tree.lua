local function condition()
  return vim.bo.filetype == 'neo-tree'
end

local statusline = {
  condition = condition,
  { provider = 'neo-tree' },
  {
    provider = function()
      return vim.b.neo_tree_source
    end,
  },
}
local winbar = {
  condition = condition,
}

return {
  statusline = statusline,
  winbar = winbar,
}
