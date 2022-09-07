local icons = require('user.setup.heirline.icons')
local utils = require('user.setup.heirline.utils')

return {
  align = { provider = '%=' },
  space = setmetatable({ provider = ' ' }, {
    __call = function(_, n)
      return { provider = string.rep(' ', n) }
    end,
  }),
  sep = { provider = icons.seperators.vert },

  slanted = function(component, color)
    return utils.surround(component, {
      left = icons.seperators.slant_left .. icons.seperators.block,
      right = icons.seperators.block .. icons.seperators.slant_right_2,
    }, color)
  end,
  slanted_right = function(component, color)
    return utils.surround(component, {
      left = icons.seperators.block,
      right = icons.seperators.block .. icons.seperators.slant_right_2,
    }, color)
  end,
}
