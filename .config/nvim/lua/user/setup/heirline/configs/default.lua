local utils = require('user.setup.heirline.utils')

local meta = utils.component('meta')
local file = utils.component('file')

local statusline = {
  meta.slanted_right('mode'),
  meta.slanted('spell'),
  meta.slanted('search'),
  meta.slanted('macro'),
  {
    flexible = 1,
    meta.slanted(file.file, 'stl.surround'),
    {},
  },
  meta.slanted('git'),
  utils.component('diagnostics'),

  meta.align,

  utils.surround('lsp', ' ', false),
  meta.blocked('wordcount'),
  meta.blocked('visual_selection'),
  meta.blocked('obsession'),
  meta.blocked('vimtex'),
  meta.blocked('lazy'),
  meta.blocked(file.type),
  meta.blocked(file.format),
  meta.blocked(file.enc),
  meta.blocked(file.position),
}

local winbar = {
  meta.space,
  file.file,
  utils.component('gps'),

  meta.align,

  utils.component('dap'),
  utils.component('diagnostics'),
  meta.space,
}

return {
  statusline = statusline,
  winbar = winbar,
}
