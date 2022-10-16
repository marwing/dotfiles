local conditions = require('heirline.conditions')
local utils = require('user.utils')

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

local wc_vimtex_data = { cmd = {} }

wc_vimtex_data.debounced_init, wc_vimtex_data.timer = utils.defer.debounce_trailing(function()
  vim.api.nvim_exec_autocmds('User', { pattern = 'user_heirline_update_wordcount_vimtex' })
end, 500)

wc_vimtex_data.group = vim.api.nvim_create_augroup('user_heirline_update_wordcount_vimtex_group', { clear = true })
wc_vimtex_data.cmd.enter = vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost' }, {
  group = wc_vimtex_data.group,
  callback = function()
    vim.api.nvim_exec_autocmds('User', { pattern = 'user_heirline_update_wordcount_vimtex' })
  end,
})
-- Visual
wc_vimtex_data.cmd.update = vim.api.nvim_create_autocmd({ 'CursorMoved', 'ModeChanged' }, {
  group = wc_vimtex_data.group,
  callback = function(args)
    if inVisual() or string.match(args.match, '[vV\22]:.*') then
      wc_vimtex_data.debounced_init()
    end
  end,
})
-- cleanup
wc_vimtex_data.cmd.cleanup = vim.api.nvim_create_autocmd('VimLeave', {
  group = wc_vimtex_data.group,
  callback = function()
    wc_vimtex_data.timer:stop()
    wc_vimtex_data.timer:close()
  end,
})

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

local wc_vimtex = {
  static = vim.tbl_extend('error', wc_vimtex_data, { cache = {} }),
  condition = function()
    return vim.b.vimtex ~= nil
  end,
  init = function(self)
    self.count = vim.fn['vimtex#misc#wordcount'] { range = get_visual_range() }
  end,
  provider = function(self)
    return tostring(self.count)
  end,
  update = { 'User', pattern = 'user_heirline_update_wordcount_vimtex' },
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
