local meta = require('user.setup.heirline.components.meta')

local function condition()
  return vim.bo.filetype == 'tagbar'
end

-- local statusline = {
--   condition = condition,
-- }

local winbar = {
  condition = condition,

  meta.align,
  { provider = 'Outline' },
  meta.align,
}

return {
  -- statusline = statusline,
  winbar = winbar,
}
