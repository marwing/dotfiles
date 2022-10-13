local conditions = require('heirline.conditions')

-- TODO: don't recompute when buffer not modifiable or readonly

local function isVisual()
  return vim.tbl_contains({ 'v', 'V', '' }, vim.fn.mode())
end

local wc_vim = {
  provider = function()
    local data = vim.fn.wordcount()
    return isVisual() and data.visual_words or data.words
  end,
}

local wc_vimtex = {
  condition = function()
    return vim.b.vimtex ~= nil
  end,
  init = function(self)
    local range
    if isVisual() then
      local vis = vim.fn.line('v')
      local cur = vim.fn.line('.')

      if vis > cur then
        vis, cur = cur, vis
      end
      range = { vis, cur }
    end
    self.count = vim.fn['vimtex#misc#wordcount'] { range = range }
  end,
  provider = function(self)
    return tostring(self.count)
  end,
  -- TODO: Find better suited autocmds (Cursorhold and InsertLeave?) or throttle updates manually (changedtick, timer)
  -- these break visual selection wordcount
  update = { 'BufEnter', 'BufWritePost' },
}

local wordcount = {
  condition = function()
    return not conditions.buffer_matches { buftype = { 'help' } }
      and conditions.buffer_matches {
        filetype = { 'asciidoc', 'help', 'mail', 'markdown', 'nroff', 'org', 'plaintex', 'rst', 'tex', 'text' },
      }
  end,

  fallthrough = false,
  wc_vimtex,
  wc_vim,
}

return wordcount
