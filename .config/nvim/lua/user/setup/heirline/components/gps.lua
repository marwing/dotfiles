local nvim_gps = require('nvim-gps')
local nvim_navic = require('nvim-navic')

local gps = {
  condition = nvim_gps.is_available,
  provider = function()
    local location = nvim_gps.get_location()
    if #location > 0 then
      return ' > ' .. location
    end
  end,
}

local navic = {
  condition = nvim_navic.is_available,
  provider = function()
    local location = nvim_navic.get_location()
    if #location > 0 then
      return ' > ' .. location
    end
  end,
}

return {
  fallthrough = false,
  navic,
  gps,
}
