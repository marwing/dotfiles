local conditions = require('heirline.conditions')
local colors = require('user.setup.heirline.colors')
local icons = require('user.setup.heirline.icons')

local function diagnostics_component(comp)
  return {
    condition = function(self)
      return self[comp] > 0
    end,
    provider = function(self)
      return ' ' .. icons.diag[comp] .. self[comp]
    end,
    hl = { fg = colors.diag[comp] },
  }
end

local diagnostics = {
  condition = conditions.has_diagnostics,
  init = function(self)
    self.error = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
    self.warning = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
    self.hint = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
    self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
  end,
  update = { 'DiagnosticChanged', 'BufEnter' },
  diagnostics_component('error'),
  diagnostics_component('warning'),
  diagnostics_component('info'),
  diagnostics_component('hint'),
}

return diagnostics
