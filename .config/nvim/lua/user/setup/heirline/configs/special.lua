local conditions = require('heirline.conditions')

local utils = require('user.setup.heirline.utils')

local file = require('user.setup.heirline.components.file')

local function condition()
  return conditions.buffer_matches {
    buftype = {
      'nofile',
      'prompt',
      'help',
      'quickfix',
    },
    filetype = {
      'startify',
      'fugitive',
    },
  }
end

local statusline = {
  condition = condition,
  file.type,
}

return {
  -- statusline = statusline,
  winbar = utils.disable_winbar(condition),
}
