local utils = require('heirline.utils')

local base = { -- gruvbox dark
  black = '#282828',
  white = '#ebdbb2',
  red = '#fb4934',
  green = '#b8bb26',
  aqua = '#8ec07c',
  blue = '#83a598',
  yellow = '#fe8019',
  gray = '#a89984',
  darkgray = '#3c3836',
  lightgray = '#504945',
  inactivegray = '#7c6f64',
}

local colors = {
  default = {
    [true] = utils.get_highlight('StatusLine'),
    -- { -- is_active
    --   fg = utils.get_highlight('StatusLine').fg, -- fg = '#ebdbb2',
    --   bg = utils.get_highlight('StatusLine').bg, -- bg = '#504945',
    --   reverse = utils.get_highlight('StatusLine').reverse,
    -- },
    [false] = utils.get_highlight('StatusLineNC'),
    -- { -- is_active
    --   fg = utils.get_highlight('StatusLineNC').fg, -- fg = '#a89984',
    --   bg = utils.get_highlight('StatusLineNC').bg, -- bg = '#3c3836',
    --   reverse = utils.get_highlight('StatusLineNC').reverse,
    -- },
  },
  diag = {
    error = utils.get_highlight('DiagnosticError').fg,
    warning = utils.get_highlight('DiagnosticWarn').fg,
    info = utils.get_highlight('DiagnosticInfo').fg,
    hint = utils.get_highlight('DiagnosticHint').fg,
  },
  git = {
    added = utils.get_highlight('GitsignsAdd').fg,
    changed = utils.get_highlight('GitsignsChange').fg,
    removed = utils.get_highlight('GitsignsDelete').fg,
  },
}

return vim.tbl_extend('keep', colors, base)
