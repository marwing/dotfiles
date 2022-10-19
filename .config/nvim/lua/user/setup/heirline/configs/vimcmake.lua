local function condition()
  return vim.bo.filetype == 'vimcmake'
end

local meta = require('user.setup.heirline.components.meta')

local cmake_config = {
  provider = function (self)
    return self.data.config
  end
}

local cmake_status = {
  provider = function (self)
    return self.data.status
  end
}

local winbar = {
  condition = condition,
  init = function (self)
    self.data = vim.fn['cmake#GetInfo']()
  end,
  meta.slanted_right(cmake_config),
  meta.space,
  cmake_status,
}

return {
  winbar = winbar,
}
