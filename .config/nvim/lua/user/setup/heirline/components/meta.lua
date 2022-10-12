local icons = require('user.setup.heirline.icons')
local utils = require('user.setup.heirline.utils')

local meta = {
  align = { provider = '%=' },
  space = setmetatable({ provider = ' ' }, {
    __call = function(_, n)
      return { provider = string.rep(' ', n) }
    end,
  }),
  sep = { provider = icons.seperators.vert },

  slant = {
    left = icons.seperators.slant_left .. icons.seperators.block,
    right = icons.seperators.block .. icons.seperators.slant_right_2,
  },
  slant_right = {
    left = icons.seperators.block,
    right = icons.seperators.block .. icons.seperators.slant_right_2,
  },
  slant_left = {
    left = icons.seperators.slant_left .. icons.seperators.block,
    right = icons.seperators.block,
  },
  block = {
    left = icons.seperators.half_block_right .. icons.seperators.block,
    right = icons.seperators.block .. icons.seperators.half_block_left,
  },
}

meta.slanted = function(component, color)
  return utils.surround(component, meta.slant, color)
end

meta.slanted_right = function(component, color)
  return utils.surround(component, meta.slant_right, color)
end

meta.slanted_left = function(component, color)
  return utils.surround(component, meta.slant_left, color)
end

meta.blocked = function(component, color)
  return utils.surround(component, meta.block, color)
end

return meta
