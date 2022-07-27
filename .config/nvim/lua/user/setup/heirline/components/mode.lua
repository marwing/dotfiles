local colors = require('user.setup.heirline.colors')
local meta = require('user.setup.heirline.components.meta')

local mode = {
  static = {
    mode_colors = {
      ['n'] = colors.gray,
      ['no'] = colors.green,
      ['nov'] = colors.green,
      ['noV'] = colors.green,
      ['no\22'] = colors.green,
      ['niI'] = colors.gray,
      ['niR'] = colors.gray,
      ['niV'] = colors.gray,
      ['nt'] = colors.gray,
      ['v'] = colors.yellow,
      ['vs'] = colors.yellow,
      ['V'] = colors.yellow,
      ['Vs'] = colors.yellow,
      ['\22'] = colors.yellow,
      ['\22s'] = colors.yellow,
      ['s'] = colors.orange,
      ['S'] = colors.orange,
      ['\19'] = colors.orange,
      ['i'] = colors.blue,
      ['ic'] = colors.blue,
      ['ix'] = colors.blue,
      ['R'] = colors.red,
      ['Rc'] = colors.red,
      ['Rx'] = colors.red,
      ['Rv'] = colors.red,
      ['Rvc'] = colors.red,
      ['Rvx'] = colors.red,
      ['c'] = colors.green,
      ['cv'] = colors.green,
      ['ce'] = colors.green,
      ['r'] = colors.red,
      ['rm'] = colors.green,
      ['r?'] = colors.green,
      ['!'] = colors.green,
      ['t'] = colors.gray,
    },
  },

  init = function(self)
    self.mode = vim.api.nvim_get_mode().mode
  end,

  -- provider = '',
  -- provider = icons.seperators.block,
  -- provider = '  ',
  meta.space(2),

  hl = function(self)
    return {
      bg = self.mode_colors[self.mode],
    }
  end,
}

return mode
