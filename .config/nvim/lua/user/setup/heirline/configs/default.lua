local utils = require('heirline.utils')
local conditions = require('heirline.conditions')

local colors = require('user.setup.heirline.colors')
local icons = require('user.setup.heirline.icons')

local meta = require('user.setup.heirline.components.meta')
local mode = require('user.setup.heirline.components.mode')
local spell = require('user.setup.heirline.components.spell')
local git = require('user.setup.heirline.components.git')
local diagnostics = require('user.setup.heirline.components.diagnostics')
local file = require('user.setup.heirline.components.file')
local lsp = require('user.setup.heirline.components.lsp')
local gps = require('user.setup.heirline.components.gps')

local statusline = {
  -- default highlighs
  hl = function()
    -- return colors.default[conditions.is_active()]
    local color = colors.default[conditions.is_active()]
    -- manually reverse colors to not set reverse for all components
    if color.reverse then
      return {
        fg = color.bg,
        bg = color.fg,
      }
    end
    return {
      fg = color.fg,
      bg = color.bg,
    }
  end,
  utils.insert(mode, spell),
  utils.insert(git, meta.space, { condition = conditions.has_diagnostics, provider = icons.seperators.vert }),
  diagnostics,

  meta.align,

  file.file,

  meta.align,

  utils.insert(lsp, meta.space),
  utils.insert(file.file_type, meta.space),
  utils.insert(file.file_format, meta.space),
  utils.insert(file.file_enc, meta.space),
  file.position,
}

local winbar = {
  gps,

  meta.align,

  file.file,
}

return {
  statusline = statusline,
  winbar = winbar,
}
