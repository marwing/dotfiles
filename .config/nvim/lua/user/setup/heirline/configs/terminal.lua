local conditions = require('heirline.conditions')
local he_utils = require('heirline.utils')

local utils = require('user.setup.heirline.utils')

local meta = utils.component('meta')
local file = utils.component('file')

local devicons = require('nvim-web-devicons')

local function condition()
  return conditions.buffer_matches {
    buftype = { 'terminal' },
  }
end

local term = {
  icon = {
    init = function(self)
      self.icon, self.icon_color = devicons.get_icon_color('terminal')
    end,
    provider = function(self)
      return self.icon
    end,
    hl = function(self)
      return { fg = self.icon_color }
    end,
  },

  command = {
    provider = function()
      return vim.api.nvim_buf_get_name(0):gsub('.*:', '')
    end,
  },
}

local statusline = {
  condition = condition,

  meta.slanted_right('mode'),
  meta.align,
  term.full,
  meta.align,
  he_utils.insert(file.format, meta.space),
  he_utils.insert(file.position, meta.space),
}

local winbar = {
  condition = condition,

  meta.space,
  term.icon,
  meta.space,
  term.command,
  meta.align,
}

return {
  statusline = statusline,
  winbar = winbar,
}
