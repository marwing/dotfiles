local utils = require('user.setup.heirline.utils')

local meta = utils.component('meta')

local function condition()
  return vim.bo.filetype == 'tagbar'
end

-- local statusline = {
--   condition = condition,
-- }

local winbar = {
  condition = condition,
  hl = {
    fg = 'wb.header.fg',
    bg = 'wb.header.bg',
    bold = true,
  },

  meta.align,
  { provider = 'Outline' },
  meta.align,
}

return {
  -- statusline = statusline,
  winbar = winbar,
}
