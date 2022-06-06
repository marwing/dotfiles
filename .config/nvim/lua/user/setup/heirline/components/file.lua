local utils = require('heirline.utils')

local devicons = require('nvim-web-devicons')

local colors = require('user.setup.heirline.colors')

local meta = require('user.setup.heirline.components.meta')

local M = {}

M.file_base = {
  init = function(self)
    self.filename = vim.api.nvim_buf_get_name(0)
  end,
}

M.file_icon = { -- FileIcon
  -- TODO: disable with condition when no icon available
  init = function(self)
    local extension = vim.fn.fnamemodify(self.filename, ':e')
    self.icon, self.icon_color = devicons.get_icon_color(self.filename, extension, { default = true })
  end,
  provider = function(self)
    return self.icon
  end,
  hl = function(self)
    return { fg = self.icon_color }
  end,
}

M.file_name = {
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
}

M.file_flags = { -- flags
  provider = '%m%r',
}

M.file = utils.insert(M.file_base, {
  hl = function()
    if vim.bo.modified then
      return { fg = colors.blue }
    end
    return nil
  end,
  meta.space,
  utils.insert(M.file_icon, meta.space),
  M.file_name,
  M.file_flags,
})

M.file_enc = {
  condition = function()
    return vim.bo.fileencoding ~= ''
  end,
  provider = function()
    return vim.bo.fileencoding
  end,
}

M.file_format = {
  condition = function()
    return vim.bo.fileformat ~= ''
  end,
  provider = function()
    return vim.bo.fileformat
  end,
}

M.file_type = {
  condition = function()
    return vim.bo.filetype ~= ''
  end,
  provider = function()
    return vim.bo.filetype
  end,
  hl = { fg = utils.get_highlight('Type').fg, bold = true },
}

M.position = {
  provider = '%(%l/%L%):%c %p%%',
}

return M
