local conditions = require('heirline.conditions')
local utils = require('heirline.utils')
local devicons = require('nvim-web-devicons')

local function condition()
  return conditions.buffer_matches {
    buftype = { 'terminal' },
  }
end

local meta = require('user.setup.heirline.components.meta')
local file = require('user.setup.heirline.components.file')
local mode = require('user.setup.heirline.components.mode')

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

  mode,
  meta.align,
  term.full,
  meta.align,
  utils.insert(file.format, meta.space),
  utils.insert(file.position, meta.space),
}

local winbar = {
  condition = condition,

  meta.space,
  term.icon,
  meta.space,
  term.command,
}

return {
  statusline = statusline,
  winbar = winbar,
}
