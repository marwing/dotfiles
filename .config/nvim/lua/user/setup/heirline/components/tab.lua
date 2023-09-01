local he_utils = require('heirline.utils')

local utils = require('user.setup.heirline.utils')
local meta = utils.component('meta')

local tab_content = {
  provider = function(self)
    return '%' .. self.tabnr .. 'T ' .. self.tabpage .. ' %T'
  end,
  hl = function(self)
    local key = self.is_active and 'active' or 'inactive'
    return {
      fg = 'tl.' .. key .. '.fg',
      bg = 'tl.' .. key .. '.bg',
    }
  end,
}

-- local tab = utils.surround(tab_content, { left = icons.seperators.slant_left, right = icons.seperators.slant_right })
local tab = meta.blocked(tab_content)

local tabline = {
  -- only show this component if there's 2 or more tabpages
  condition = function()
    return #vim.api.nvim_list_tabpages() >= 2
  end,
  hl = {
    fg = 'tl.empty.fg',
    bg = 'tl.empty.bg',
  },
  meta.align,
  he_utils.make_tablist(tab),
}

return tabline
