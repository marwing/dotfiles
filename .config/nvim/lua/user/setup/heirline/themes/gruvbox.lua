return function()
  local h = require('heirline.utils').get_highlight
  local colors = require('gruvbox.palette').get_base_colors()

  local gruvbox = {
    -- have to manually reverse colors for statusline
    -- for some reason gruvbox sets colors reversed and reverse ??
    stl = {
      fg = h('StatusLine').bg,
      bg = h('StatusLine').fg,
      surround = colors.bg1,
    },
    wb = {
      fg = colors.gray,
      bg = 'NONE',
      header = {
        fg = colors.fg2,
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
      bg = colors.bg1,
      normal = colors.gray,
      op = colors.green,
      visual = colors.orange,
      visual_line = colors.orange,
      visual_block = colors.orange,
      select = colors.orange,
      select_line = colors.orange,
      select_block = colors.orange,
      insert = colors.blue,
      replace = colors.red,
      virtual_replace = colors.red,
      command = colors.green,
      enter = colors.red,
      more = colors.green,
      confirm = colors.green,
      shell = colors.green,
      terminal = colors.gray,
    },

    file = {
      modified = colors.blue,
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
      fg = colors.fg0,
      bg = colors.neutral_red,
    },

    search = {
      fg = colors.bg1,
      bg = colors.aqua,
    },

    spell = {
      fg = colors.fg2,
      bg = colors.bg4,
    },

    lazy = colors.aqua,
  }

  return gruvbox
end
