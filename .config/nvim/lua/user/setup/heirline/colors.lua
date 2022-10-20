local h = require('heirline.utils').get_highlight

local base = {
  bg0 = h('GruvboxBg0').fg, -- black
  bg1 = h('GruvboxBg1').fg, -- darkgray
  bg2 = h('GruvboxBg2').fg, -- lightgray
  bg3 = h('GruvboxBg3').fg,
  bg4 = h('GruvboxBg4').fg, -- inactivegray
  fg0 = h('GruvboxFg0').fg,
  fg1 = h('GruvboxFg1').fg, -- white
  fg2 = h('GruvboxFg2').fg,
  fg3 = h('GruvboxFg3').fg,
  fg4 = h('GruvboxFg4').fg, -- gray

  aqua = h('GruvboxAqua').fg,
  blue = h('GruvboxBlue').fg,
  gray = h('GruvboxGray').fg,
  green = h('GruvboxGreen').fg,
  orange = h('GruvboxOrange').fg,
  purple = h('GruvboxPurple').fg,
  red = h('GruvboxRed').fg,
  yellow = h('GruvboxYellow').fg,
}

local colors = {
  -- have to manually reverse colors for statusline
  -- for some reaseon gruvbox sets colors reversed and reverse ??
  default = {
    fg = h('StatusLine').bg,
    bg = h('StatusLine').fg,
  },
  diag = {
    error = h('DiagnosticError').fg,
    warning = h('DiagnosticWarn').fg,
    info = h('DiagnosticInfo').fg,
    hint = h('DiagnosticHint').fg,
  },
  git = {
    bg = base.bg0,
    added = h('GitsignsAdd').fg,
    changed = h('GitsignsChange').fg,
    removed = h('GitsignsDelete').fg,
  },
  filetype = h('Type').fg,
}

return vim.tbl_extend('keep', colors, base)
