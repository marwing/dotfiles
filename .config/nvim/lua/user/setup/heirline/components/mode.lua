local colors = require('user.setup.heirline.colors')
local icons = require('user.setup.heirline.icons')

return {
  static = {
    mode_map = {
      n = 'normal',
      no = 'op',
      nov = 'op',
      noV = 'op',
      ['no\22'] = 'op',
      niI = 'normal',
      niR = 'normal',
      niV = 'normal',
      nt = 'normal',
      ntT = 'normal',
      v = 'visual',
      vs = 'visual',
      V = 'visual_line',
      Vs = 'visual_line',
      ['\22'] = 'visual_block',
      ['\22s'] = 'visual_block',
      s = 'select',
      S = 'select_line',
      ['\19'] = 'select_block',
      i = 'insert',
      ic = 'insert',
      ix = 'insert',
      R = 'replace',
      Rc = 'replace',
      Rx = 'replace',
      Rv = 'virtual_replace',
      Rvc = 'virtual_replace',
      Rvx = 'virtual_replace',
      c = 'command',
      cv = 'command',
      r = 'enter',
      rm = 'more',
      ['r?'] = 'confirm',
      ['!'] = 'shell',
      t = 'terminal',
    },
    mode_label = {
      normal = 'NORMAL',
      op = 'OP',
      visual = 'VISUAL',
      visual_line = 'VISUAL LINE',
      visual_block = 'VISUAL BLOCK',
      select = 'SELECT',
      select_line = 'SELECT LINE',
      select_block = 'SELECT BLOCK',
      insert = 'INSERT',
      replace = 'REPLACE',
      virtual_replace = 'V-REPLACE',
      command = 'COMMAND',
      enter = 'ENTER',
      more = 'MORE',
      confirm = 'CONFIRM',
      shell = 'SHELL',
      terminal = 'TERMINAL',
    },
    mode_colors = {
      normal = colors.gray,
      op = colors.green,
      visual = colors.orange,
      visual_line = colors.orange,
      visual_block = colors.orange,
      select = colors.orange,
      select_line = colors.orange,
      select_block = colors.orange,
      insert = colors.blue,
      replace = colors.red,
      virtual_replace = colors.red,
      command = colors.green,
      enter = colors.red,
      more = colors.green,
      confirm = colors.green,
      shell = colors.green,
      terminal = colors.gray,
    },
  },

  init = function(self)
    self.mode = self.mode_map[vim.api.nvim_get_mode().mode]
  end,

  hl = function(self)
    return {
      fg = colors.bg1,
      bg = self.mode_colors[self.mode],
      bold = true,
    }
  end,

  provider = function(self)
    return icons.mode .. ' ' .. self.mode_label[self.mode]
  end,

  update = 'ModeChanged',
}
