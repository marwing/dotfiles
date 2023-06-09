return {
  condition = function(self)
    local lines = vim.api.nvim_buf_line_count(0)
    if lines > 50000 then
      return
    end

    local query = vim.fn.getreg('/')
    if query == '' then
      return
    end

    if query:match('\\%%%d+l') then
      return
    end

    local ok, search_count = pcall(vim.fn.searchcount, { recompute = 1, maxcount = -1 })
    if not ok then
      return false
    end

    local active = vim.v.hlsearch and vim.v.hlsearch == 1 and search_count.total > 0
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
    fg = 'search.fg',
    bg = 'search.bg',
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
