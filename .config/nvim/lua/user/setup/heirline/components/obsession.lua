local icons = require('user.setup.heirline.icons')

return {
  condition = function(self)
    if not vim.g.loaded_obsession then
      return false
    end

    self.status = vim.fn.ObsessionStatus(icons.obsession.active, icons.obsession.inactive)
    -- only show when active, remove when setting actual icon/string for inactive
    return self.status ~= icons.obsession.inactive
  end,
  provider = function(self)
    return self.status
  end,
}
