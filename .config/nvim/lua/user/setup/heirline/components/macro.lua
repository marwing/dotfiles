return {
  condition = function(self)
    self.reg = vim.fn.reg_recording()
    return self.reg ~= ''
  end,
  provider = function(self)
    return '@' .. self.reg
  end,
  hl = {
    fg = 'macro.fg',
    bg = 'macro.bg',
    bold = true,
  },
  update = { 'RecordingEnter', 'RecordingLeave' },
}
