local conditions = require('heirline.conditions')

local function condition()
  return conditions.buffer_matches {
    buftype = { 'nofile', 'prompt', 'help', 'quickfix' },
    filetype = { [[neo\-tree]], '^git.*', 'fugitive' },
  }
end

local statusline = {
  condition = condition,
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
