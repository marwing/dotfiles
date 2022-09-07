local colors = require('user.setup.heirline.colors')

return {
  condition = function(self)
    local lines = vim.api.nvim_buf_line_count(0)
    if lines > 50000 then
      return
    end

    ---@diagnostic disable-next-line: missing-parameter
    local query = vim.fn.getreg('/')
    if query == '' then
      return
    end

    if query:find('@') then
      return
    end

    local search_count = vim.fn.searchcount { recompute = 1, maxcount = -1 }
    local active = false
    if vim.v.hlsearch and vim.v.hlsearch == 1 and search_count.total > 0 then
      active = true
    end
    if not active then
      return
    end

    query = query:gsub([[^\V]], '')
    query = query:gsub([[\<]], ''):gsub([[\>]], '')

    self.query = query
    self.count = search_count
    return true
  end,

  hl = {
    fg = colors.bg1,
    bg = colors.aqua,
    bold = true,
  },

  provider = function(self)
    return table.concat {
      self.query,
      ' [',
      self.count.current,
      '/',
      self.count.total,
      ']',
    }
  end,
}
