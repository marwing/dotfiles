local icons = require('user.setup.heirline.icons')

return {
  align = { provider = '%=' },
  space = setmetatable({ provider = ' ' }, {
    __call = function(_, n)
      return { provider = string.rep(' ', n) }
    end,
  }),
  sep = { provider = icons.seperators.vert },
}
