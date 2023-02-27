return function()
  local colors = require('tokyonight.colors').setup()

  local tokyonight = {
    stl = {
      fg = colors.fg,
      bg = colors.bg_statusline,
      surround = colors.bg_highlight,
    },
    wb = {
      fg = colors.fg_dark,
      bg = colors.none,
      header = {
        fg = colors.fg,
        bg = colors.bg_sidebar,
      },
    },

    mode = {
      bg = colors.bg,
      normal = colors.blue,
      op = colors.yellow,
      visual = colors.magenta,
      visual_line = colors.magenta,
      visual_block = colors.magenta,
      select = colors.magenta,
      select_line = colors.magenta,
      select_block = colors.magenta,
      insert = colors.green,
      replace = colors.red,
      virtual_replace = colors.red,
      command = colors.yellow,
      enter = colors.red,
      more = colors.yellow,
      confirm = colors.yellow,
      shell = colors.yellow,
      terminal = colors.green1,
    },

    file = {
      modified = colors.blue,
      readonly = colors.dark5,
      type = colors.blue,
    },

    git = {
      added = colors.git.add,
      changed = colors.git.change,
      removed = colors.git.delete,
    },

    diag = {
      error = colors.error,
      warning = colors.warning,
      info = colors.info,
      hint = colors.hint,
    },

    macro = {
      fg = colors.bg,
      bg = colors.red,
    },

    search = {
      fg = colors.fg,
      bg = colors.bg_search,
    },

    spell = {
      fg = colors.fg,
      bg = colors.bg_highlight,
    },

    lazy = colors.blue1,
  }

  return tokyonight
end
