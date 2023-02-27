return {
  condition = function()
    return vim.wo.spell
  end,

  hl = {
    fg = 'spell.fg',
    bg = 'spell.bg',
    bold = true,
  },

  provider = function()
    return string.upper(vim.bo.spelllang)
  end,
}
