local gps = {
  condition = function()
    local nvim_gps = package.loaded['nvim-gps']
    return nvim_gps and nvim_gps.is_available()
  end,
  provider = function()
    local location = require('nvim-gps').get_location()
    if #location > 0 then
      return ' | ' .. location
    end
  end,
}

local navic = {
  condition = function()
    local nvim_navic = package.loaded['nvim-navic']
    return nvim_navic and nvim_navic.is_available()
  end,
  provider = function()
    local location = require('nvim-navic').get_location()
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
