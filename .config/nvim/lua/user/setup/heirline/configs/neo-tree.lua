local meta = require('user.setup.heirline.components.meta')

local function condition()
  return vim.bo.filetype == 'neo-tree'
end

local TreeType = {
  static = {
    type_map = setmetatable({
      filesystem = 'File Explorer',
      buffers = 'Open Buffers',
      git_status = 'Git Status',
    }, {
      __index = function(_, key)
        return tostring(key) .. ' - unknown'
      end,
    }),
  },
  provider = function(self)
    return self.type_map[vim.b.neo_tree_source]
  end,
}

-- local statusline = {
--   condition = condition,

--   { provider = 'neo-tree' },
--   meta.sep,
--   {
--     provider = function()
--       return vim.b.neo_tree_source
--     end,
--   },
-- }

local winbar = {
  condition = condition,

  meta.align,
  TreeType,
  meta.align,
}

return {
  -- statusline = statusline,
  winbar = winbar,
}
