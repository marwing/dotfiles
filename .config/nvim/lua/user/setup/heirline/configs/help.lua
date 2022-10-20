local meta = require('user.setup.heirline.components.meta')
local file = require('user.setup.heirline.components.file')

local function condition()
  return vim.bo.buftype == 'help'
end

local statusline = {
  condition = condition,
  file.type,
  file.short_file,
}

local winbar = {
  condition = condition,
  meta.align,
  file.short_file,
}

return {
  statusline = statusline,
  winbar = winbar,
}
