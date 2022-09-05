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
      'startify',
      '^git.*',
      'fugitive',
    },
  }
end

local statusline = {
  condition = condition,
  file.type,
}

local winbar = {
  condition = condition,
  init = function()
    vim.wo.winbar = nil
  end,
}

return {
  statusline = statusline,
  winbar = winbar,
}
