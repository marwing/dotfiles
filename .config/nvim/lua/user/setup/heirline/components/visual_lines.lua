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

    if self.mode == '\22' then
      local col = {
        visual[3],
        current[3],
      }
      if col[1] > col[2] then
        col[1], col[2] = col[2], col[1]
      end
      self.col = col[2] - col[1] + 1
    end
  end,
  provider = function(self)
    if self.mode ~= '\22' then
      return self.line
    else
      return self.line .. 'x' .. self.col
    end
  end,
}
