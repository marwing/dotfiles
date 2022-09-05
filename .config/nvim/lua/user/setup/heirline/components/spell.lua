local meta = require('user.setup.heirline.components.meta')

local spell = {
  condition = function()
    return vim.wo.spell
  end,

  hl = {
    bold = true,
  },

  meta.space,
  {
    provider = function()
      return vim.bo.spelllang
    end,
  },
  meta.space,
}

return spell
