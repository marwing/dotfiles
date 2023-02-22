return {
  condition = function(self)
    self.mode = vim.fn.mode()
    return vim.tbl_contains({ 'v', 'V', '\22' }, self.mode)
  end,
  init = function(self)
    local visual = vim.fn.getpos('v')
    local current = vim.fn.getpos('.')

    local line = {
      vis = visual[2],
      cur = current[2],
    }
    if line.vis > line.cur then
      line.vis, line.cur = line.cur, line.vis
    end
    self.line = line.cur - line.vis + 1

    local col = {
      vis = visual[3],
      cur = current[3],
    }
    if col.vis > col.cur then
      col.vis, col.cur = col.cur, col.vis
    end
    self.col = col.cur - col.vis + 1
  end,
  provider = function(self)
    if self.mode == '\22' then
      return self.line .. 'x' .. self.col
    elseif self.mode == 'v' and self.line == 1 then
      return self.col
    else
      return self.line
    end
  end,
}
