return function()
  local h = require('heirline.utils').get_highlight
  local colors = require('gruvbox').palette

  local gruvbox = {
    -- have to manually reverse colors for statusline
    -- for some reason gruvbox sets colors reversed and reverse ??
    stl = {
      fg = h('StatusLine').bg,
      bg = h('StatusLine').fg,
      surround = colors.dark1,
    },
    wb = {
      fg = colors.gray,
      bg = 'NONE',
      header = {
        fg = colors.light2,
        bg = 'NONE',
      },
    },
    tl = {
      active = {
        fg = h('TabLineSel').fg,
        bg = h('TabLineSel').bg,
      },
      inactive = {
        fg = h('TabLine').fg,
        bg = h('TabLine').bg,
      },
      empty = {
        fg = h('StatusLine').bg,
        bg = h('StatusLine').fg,
      },
    },

    mode = {
      bg = colors.dark1,
      normal = colors.gray,
      op = colors.bright_green,
      visual = colors.bright_orange,
      visual_line = colors.bright_orange,
      visual_block = colors.bright_orange,
      select = colors.bright_orange,
      select_line = colors.bright_orange,
      select_block = colors.bright_orange,
      insert = colors.bright_blue,
      replace = colors.bright_red,
      virtual_replace = colors.bright_red,
      command = colors.bright_green,
      enter = colors.bright_red,
      more = colors.bright_green,
      confirm = colors.bright_green,
      shell = colors.bright_green,
      terminal = colors.gray,
    },

    file = {
      modified = colors.bright_blue,
      readonly = colors.gray,
      type = h('Type').fg,
    },

    git = {
      added = h('GitsignsAdd').fg,
      changed = h('GitsignsChange').fg,
      removed = h('GitsignsDelete').fg,
    },

    diag = {
      error = h('DiagnosticError').fg,
      warning = h('DiagnosticWarn').fg,
      info = h('DiagnosticInfo').fg,
      hint = h('DiagnosticHint').fg,
    },

    macro = {
      fg = colors.light0,
      bg = colors.neutral_red,
    },

    search = {
      fg = colors.dark1,
      bg = colors.bright_aqua,
    },

    spell = {
      fg = colors.light2,
      bg = colors.dark4,
    },

    lazy = colors.bright_aqua,
  }

  return gruvbox
end
