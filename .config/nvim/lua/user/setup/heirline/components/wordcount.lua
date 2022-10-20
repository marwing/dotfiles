local conditions = require('heirline.conditions')

local utils = require('user.setup.heirline.utils')

-- TODO: don't recompute when buffer not modifiable or readonly

local function inVisual()
  return vim.tbl_contains({ 'v', 'V', '\22' }, vim.fn.mode())
end

local wc_vim = {
  provider = function()
    local data = vim.fn.wordcount()
    return inVisual() and data.visual_words or data.words
  end,
}

local get_visual_range = function()
  if inVisual() then
    local vis = vim.fn.line('v')
    local cur = vim.fn.line('.')

    if vis > cur then
      vis, cur = cur, vis
    end
    return { vis, cur }
  end
end

local static, update = utils.defer('wordcount_vimtex', {
  events = {
    bypass = { 'BufEnter', 'BufWritePost' },
    defer = { 'CursorMoved', 'ModeChanged' },
  },
  callback = function(callback, args)
    if inVisual() or string.match(args.match, '[vV\22]:.*') then
      callback()
    end
  end,
})

local wc_vimtex = {
  static = static,
  condition = function()
    return vim.b.vimtex ~= nil
  end,
  init = function(self)
    self.count = vim.fn['vimtex#misc#wordcount'] { range = get_visual_range() }
  end,
  provider = function(self)
    return tostring(self.count)
  end,
  update = update,
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
