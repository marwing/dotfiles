local devicons = require('nvim-web-devicons')
local colors = require('user.setup.heirline.colors')

local M = {}

M.file = {
  init = function(self)
    self.filename = vim.api.nvim_buf_get_name(0)
  end,
  hl = function()
    if vim.bo.modified then
      return { fg = colors.blue }
    end
    return nil
  end,
  { provider = ' ' },
  { -- FileIcon
    init = function(self)
      local extension = vim.fn.fnamemodify(self.filename, ':e')
      self.icon, self.icon_color = devicons.get_icon_color(self.filename, extension, { default = true })
    end,
    provider = function(self)
      return self.icon .. ' '
    end,
    hl = function(self)
      return { fg = self.icon_color }
    end,
  },
  { -- FileName
    -- provider = function(self)
    --   if self.filename == '' then
    --     return '[No Name]'
    --   end

    --   local filename = vim.fn.fnamemodify(self.filename, ':~:.')

    --   if not conditions.width_percent_below(#filename, 0.25) then
    --     filename = vim.fn.pathshorten(filename)
    --   end

    --   return filename
    -- end,
    provider = '%f',
  },
  { -- flags
    provider = '%m%r',
  },
}

-- M.fileenc = {
--   provider = function()
--     return vim.bo.filetype
--   end,
-- }

M.position = {
  provider = '%(%l/%L%):%c %p%%',
}

return M
