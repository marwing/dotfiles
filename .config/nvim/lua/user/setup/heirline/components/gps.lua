local colors = require('user.setup.heirline.colors')

local gps = {
  condition = require('nvim-gps').is_available,
  provider = require('nvim-gps').get_location,
  hl = { fg = colors.gray },
}

return gps
