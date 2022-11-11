local utils = require('heirline.utils')

local colors = require('user.setup.heirline.colors')

local meta = require('user.setup.heirline.components.meta')

local devicons = require('nvim-web-devicons')

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

M.file = utils.insert(M.file_base, {
  utils.insert(M.file_icon, meta.space),
  M.file_name,
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
