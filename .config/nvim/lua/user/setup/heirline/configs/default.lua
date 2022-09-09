local he_utils = require('heirline.utils')

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
  hl = colors.default,

  meta.slanted_right(mode),
  meta.slanted(spell),
  meta.slanted(search),
  meta.slanted(file.short_file, colors.bg1),
  meta.slanted(git),
  diagnostics,

  meta.align,

  he_utils.insert(lsp, meta.space),
  he_utils.insert(file.type, meta.space),
  he_utils.insert(file.format, meta.space),
  he_utils.insert(file.enc, meta.space),
  he_utils.insert(file.position, meta.space),
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
