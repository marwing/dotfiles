local M = require('lualine.component'):extend()

local default_options = {
  symbols = { enabled = '$', disabled = '' },
}

function M:init(options)
  M.super.init(self, options)
  self.options = vim.tbl_deep_extend('keep', self.options or {}, default_options)
end

function M:update_status()
  return vim.fn.ObsessionStatus(self.options.symbols.enabled, self.options.symbols.disabled)
end

return M
