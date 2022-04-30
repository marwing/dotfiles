local M = require('lualine.component'):extend()

function M:update_status()
  if vim.opt.spell:get() then
    return vim.fn.toupper(vim.opt.spelllang:get()[1])
  end
  return ''
end

return M