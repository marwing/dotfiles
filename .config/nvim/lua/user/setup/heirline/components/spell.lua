local icons = require('user.setup.heirline.icons')

local spell = {
  condition = function()
    return vim.wo.spell
  end,
  provider = function()
    return icons.seperators.vert .. ' ' .. vim.bo.spelllang .. ' '
  end,
}

return spell
