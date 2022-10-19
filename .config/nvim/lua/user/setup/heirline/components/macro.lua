local colors = require('user.setup.heirline.colors')

return {
  condition = function(self)
    self.reg = vim.fn.reg_recording()
    return self.reg ~= ''
  end,
  provider = function(self)
    return '@' .. self.reg
  end,
  hl = {
    fg = colors.fg0,
    bg = colors.red,
    bold = true,
  },
}
