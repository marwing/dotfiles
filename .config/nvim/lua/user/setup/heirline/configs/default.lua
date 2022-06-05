local utils = require('heirline.utils')
local conditions = require('heirline.conditions')

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
    local hlg = conditions.is_active() and 'StatusLine' or 'StatusLineNC'
    -- manually reverse colors to not set reverse for all components
    if hlg.reverse then
      return {
        fg = utils.get_highlight(hlg).bg,
        bg = utils.get_highlight(hlg).fg,
      }
    end
    return {
      fg = utils.get_highlight(hlg).fg,
      bg = utils.get_highlight(hlg).bg,
    }
  end,
  utils.insert(mode, spell),
  utils.insert(git, meta.space, { condition = conditions.has_diagnostics, provider = icons.seperators.vert }),
  diagnostics,

  meta.align,

  file.file,

  meta.align,

  lsp,
  meta.space,
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
