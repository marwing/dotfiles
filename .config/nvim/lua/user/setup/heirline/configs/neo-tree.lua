local utils = require('user.setup.heirline.utils')

local meta = utils.component('meta')

local function condition()
  return vim.bo.filetype == 'neo-tree'
end

local tree_type = {
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
  hl = {
    fg = "wb.header.fg",
    bg = "wb.header.bg",
    bold = true,
  },

  meta.align,
  tree_type,
  meta.align,
}

return {
  -- statusline = statusline,
  winbar = winbar,
}
