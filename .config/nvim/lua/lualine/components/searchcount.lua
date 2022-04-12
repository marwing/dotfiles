local M = require('lualine.component'):extend()

function M:update_status()
  if vim.v.hlsearch == 0 then
    return ""
  end
  local data = vim.fn.searchcount()
  -- if not data or data.total == 0 then
  --   return ''
  -- end
  return '/' .. vim.fn.getreg('/') .. ' [' .. data.current .. '/' .. data.total .. ']'
end

return M
