local utils = require('heirline.utils')

local devicons = require('nvim-web-devicons')

local colors = require('user.setup.heirline.colors')
local icons = require('user.setup.heirline.icons')
local meta = require('user.setup.heirline.components.meta')

local M = {}

M.file_icon = {
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

M.short_file_name = {
  provider = '%t',
}

M.file_flags = {
  provider = '%m%r',
}

M.file_base = {
  init = function(self)
    self.filename = vim.api.nvim_buf_get_name(0)
  end,
  hl = function()
    if vim.bo.modified then
      return { fg = colors.blue }
    elseif not vim.bo.modifiable or vim.bo.readonly then
      return { fg = colors.gray }
    end
    return nil
  end,
}

M.long_file = utils.insert(M.file_base, {
  utils.insert(M.file_icon, meta.space),
  M.file_name,
  M.file_flags,
})

M.short_file = utils.insert(M.file_base, {
  utils.insert(M.file_icon, meta.space),
  M.short_file_name,
})

M.enc = {
  condition = function()
    return vim.bo.fileencoding ~= ''
  end,
  provider = function()
    return vim.bo.fileencoding
  end,
}

M.format = {
  condition = function()
    return vim.bo.fileformat ~= ''
  end,
  provider = function()
    -- return icons.enc[vim.bo.fileformat]
    return vim.bo.fileformat
  end,
}

M.type = {
  condition = function()
    return vim.bo.filetype ~= ''
  end,
  provider = function()
    return vim.bo.filetype
  end,
  hl = {
    fg = colors.filetype,
    bold = true,
  },
}

M.position = {
  provider = '%(%l/%L%):%c %p%%',
}

return M
