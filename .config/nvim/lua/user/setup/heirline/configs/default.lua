local he_utils = require('heirline.utils')

local colors = require('user.setup.heirline.colors')

local meta = require('user.setup.heirline.components.meta')
local mode = require('user.setup.heirline.components.mode')
local spell = require('user.setup.heirline.components.spell')
local search = require('user.setup.heirline.components.search')
local file = require('user.setup.heirline.components.file')
local git = require('user.setup.heirline.components.git')
local diagnostics = require('user.setup.heirline.components.diagnostics')
local lsp = require('user.setup.heirline.components.lsp')
local wordcount = require('user.setup.heirline.components.wordcount')
local obsession = require('user.setup.heirline.components.obsession')
local vimtex = require('user.setup.heirline.components.vimtex')
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
  meta.blocked(wordcount),
  meta.blocked(obsession),
  meta.blocked(vimtex),
  meta.blocked(file.type),
  meta.blocked(file.format),
  meta.blocked(file.enc),
  meta.blocked(file.position),
}

local winbar = {
  hl = { fg = colors.gray },

  meta.space,
  file.short_file,
  gps,

  meta.align,

  diagnostics,
  meta.space,
}

return {
  statusline = statusline,
  winbar = winbar,
}
