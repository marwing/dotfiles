local M = require('lualine.component'):extend()

local default_options = {
  symbols = { linenr = '', linecnt = '☰', charnr = '' },
}

function M:init(options)
  M.super.init(self, options)
  self.options = vim.tbl_deep_extend('keep', self.options or {}, default_options)
end

function M:update_status()
  return '%p%% '
    .. self.options.symbols.linenr
    .. ':%l/%L'
    .. self.options.symbols.linecnt
    .. ' '
    .. self.options.symbols.charnr
    .. ':%v'
end

return M
