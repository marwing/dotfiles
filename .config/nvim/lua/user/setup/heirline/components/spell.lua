local colors = require('user.setup.heirline.colors')

return {
  condition = function()
    return vim.wo.spell
  end,

  hl = {
    fg = colors.fg2,
    bg = colors.bg4,
    bold = true,
  },

  provider = function()
    return string.upper(vim.bo.spelllang)
  end,
}
