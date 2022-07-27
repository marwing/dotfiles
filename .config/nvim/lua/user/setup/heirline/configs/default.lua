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
  -- default highlighs
  hl = function()
    return colors.default[conditions.is_active()]
  end,
  mode,
  spell,
  search,
  git,
  diagnostics,

  meta.align,

  file.file,

  meta.align,

  utils.insert(lsp, meta.space),
  utils.insert(file.file_type, meta.space),
  utils.insert(file.file_format, meta.space),
  utils.insert(file.file_enc, meta.space),
  utils.insert(file.position, meta.space),
  mode,
}

local winbar = {
  hl = { fg = colors.gray },

  file.file,
  gps,
}

return {
  statusline = statusline,
  winbar = winbar,
}
