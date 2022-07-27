local conditions = require('heirline.conditions')

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
      [[neo\-tree]],
      'startify',
      '^git.*',
      'fugitive',
    },
  }
end

local statusline = {
  condition = condition,
  file.file_type,
}
local winbar = {
  condition = condition,
  init = function()
    vim.opt_local.winbar = nil
  end,
}

return {
  statusline = statusline,
  winbar = winbar,
}
