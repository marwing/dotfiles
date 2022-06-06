local function condition()
  return vim.bo.filetype == 'help'
end

local meta = require('user.setup.heirline.components.meta')
local file = require('user.setup.heirline.components.file')

local statusline = nil
-- {
--   condition = condition,
--   file.file,
-- }

local winbar = {
  condition = condition,
  meta.align,
  file.file,
}

return {
  statusline = statusline,
  winbar = winbar,
}
