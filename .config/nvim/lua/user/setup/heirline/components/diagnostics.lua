local conditions = require('heirline.conditions')

local icons = require('user.setup.heirline.icons')

local function diagnostics_component(comp)
  return {
    condition = function(self)
      return self[comp] > 0
    end,
    provider = function(self)
      return ' ' .. icons.diag[comp] .. ' ' .. self[comp]
    end,
    hl = { fg = 'diag.' .. comp },
  }
end

local diagnostics = {
  condition = conditions.has_diagnostics,
  init = function(self)
    local counts = vim.diagnostic.count()
    self.error = counts[vim.diagnostic.severity.ERROR] or 0
    self.warning = counts[vim.diagnostic.severity.WARN] or 0
    self.hint = counts[vim.diagnostic.severity.HINT] or 0
    self.info = counts[vim.diagnostic.severity.INFO] or 0
  end,
  update = { 'DiagnosticChanged', 'BufEnter' },
  diagnostics_component('error'),
  diagnostics_component('warning'),
  diagnostics_component('info'),
  diagnostics_component('hint'),
}

return diagnostics
