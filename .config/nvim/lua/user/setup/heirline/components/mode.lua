local colors = require('user.setup.heirline.colors')
local icons = require('user.setup.heirline.icons')

local mode = {
  static = {
    mode_names = {
      ['n'] = 'NORMAL',
      ['no'] = 'O-PENDING',
      ['nov'] = 'O-PENDING',
      ['noV'] = 'O-PENDING',
      ['no\22'] = 'O-PENDING',
      ['niI'] = 'NORMAL',
      ['niR'] = 'NORMAL',
      ['niV'] = 'NORMAL',
      ['nt'] = 'NORMAL',
      ['v'] = 'VISUAL',
      ['vs'] = 'VISUAL',
      ['V'] = 'V-LINE',
      ['Vs'] = 'V-LINE',
      ['\22'] = 'V-BLOCK',
      ['\22s'] = 'V-BLOCK',
      ['s'] = 'SELECT',
      ['S'] = 'S-LINE',
      ['\19'] = 'S-BLOCK',
      ['i'] = 'INSERT',
      ['ic'] = 'INSERT',
      ['ix'] = 'INSERT',
      ['R'] = 'REPLACE',
      ['Rc'] = 'REPLACE',
      ['Rx'] = 'REPLACE',
      ['Rv'] = 'V-REPLACE',
      ['Rvc'] = 'V-REPLACE',
      ['Rvx'] = 'V-REPLACE',
      ['c'] = 'COMMAND',
      ['cv'] = 'EX',
      ['ce'] = 'EX',
      ['r'] = 'REPLACE',
      ['rm'] = 'MORE',
      ['r?'] = 'CONFIRM',
      ['!'] = 'SHELL',
      ['t'] = 'TERMINAL',
    },
    mode_colors = {
      ['NORMAL'] = colors.gray,
      ['O-PENDING'] = colors.green,
      ['VISUAL'] = colors.yellow,
      ['V-LINE'] = colors.yellow,
      ['V-BLOCK'] = colors.yellow,
      ['SELECT'] = colors.orange,
      ['S-LINE'] = colors.orange,
      ['S-BLOCK'] = colors.orange,
      ['INSERT'] = colors.blue,
      ['REPLACE'] = colors.red,
      ['V-REPLACE'] = colors.red,
      ['COMMAND'] = colors.green,
      ['EX'] = colors.green,
      ['MORE'] = colors.green,
      ['CONFIRM'] = colors.green,
      ['SHELL'] = colors.green,
      ['TERMINAL'] = colors.gray,
    },
  },

  init = function(self)
    self.mode = vim.api.nvim_get_mode().mode
    self.mode_string = self.mode_names[self.mode]
  end,

  provider = function(self)
    return ' ' .. self.mode_string .. ' '
  end,

  hl = function(self)
    return {
      fg = colors.black,
      bg = self.mode_colors[self.mode_string],
      bold = true,
    }
  end,

  -- update = 'ModeChanged', -- FIX: breaks display command mode until char // may be caused by cmp-cmdline
}

return mode
