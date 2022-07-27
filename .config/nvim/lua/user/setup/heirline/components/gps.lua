local colors = require('user.setup.heirline.colors')
local nvim_gps = require('nvim-gps')

local gps = {
  condition = nvim_gps.is_available,
  provider = function()
    local location = nvim_gps.get_location()
    if #location > 0 then
      return ' > ' .. location
    end
  end,
  hl = { fg = colors.gray },
}

return gps
