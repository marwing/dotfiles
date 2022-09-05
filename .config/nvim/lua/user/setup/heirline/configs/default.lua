local utils = require('heirline.utils')
local conditions = require('heirline.conditions')

local colors = require('user.setup.heirline.colors')

local meta = require('user.setup.heirline.components.meta')
local mode = require('user.setup.heirline.components.mode')
local spell = require('user.setup.heirline.components.spell')
local search = require('user.setup.heirline.components.search')
local git = require('user.setup.heirline.components.git')
local diagnostics = require('user.setup.heirline.components.diagnostics')
local file = require('user.setup.heirline.components.file')
local lsp = require('user.setup.heirline.components.lsp')
local gps = require('user.setup.heirline.components.gps')

local statusline = {
  -- default highlights
  hl = function()
    return colors.default[conditions.is_active()]
  end,

  mode,
  search,
  utils.insert(spell, meta.sep),
  meta.space,
  file.short_file,
  meta.space,
  git,
  diagnostics,

  meta.align,

  utils.insert(lsp, meta.space),
  utils.insert(file.type, meta.space),
  utils.insert(file.format, meta.space),
  utils.insert(file.enc, meta.space),
  utils.insert(file.position, meta.space),
}

local winbar = {
  hl = { fg = colors.gray },

  meta.space,
  file.short_file,
  gps,
}

return {
  statusline = statusline,
  winbar = winbar,
}
