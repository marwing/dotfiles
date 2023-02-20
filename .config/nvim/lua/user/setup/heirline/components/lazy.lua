local colors = require('user.setup.heirline.colors')

return {
  condition = require('lazy.status').has_updates,
  provider = require('lazy.status').updates,
  hl = {
    fg = colors.aqua
  }
}
