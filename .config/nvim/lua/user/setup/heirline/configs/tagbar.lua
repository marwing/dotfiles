local meta = require('user.setup.heirline.components.meta')
local colors = require('user.setup.heirline.colors')

local function condition()
  return vim.bo.filetype == 'tagbar'
end

-- local statusline = {
--   condition = condition,
-- }

local winbar = {
  condition = condition,
  hl = {
    fg = colors.fg2,
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
