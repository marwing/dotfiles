local M = require('lualine.component'):extend()

local default_options = {
  sources = {
    vim = { enabled = true, filetypes = 'all' },
    visual = { enabled = true, filetypes = 'all' },
    vimtex = { enabled = true, filetypes = { 'tex', 'latex', 'plaintex' } },
  },
  filetypes = { 'asciidoc', 'help', 'mail', 'markdown', 'nroff', 'org', 'plaintex', 'rst', 'tex', 'text' },
}

-- utility functions
local function intable(value, table)
  if table == 'all' then
    return true
  end

  for _, elem in ipairs(table) do
    if elem == value then
      return true
    end
  end
  return false
end

local function inVisual()
  return intable(vim.fn.mode(), { "v", "V", "" })
end

-- vimtex
M.vimtex = {}
function M.vimtex.setup(self)
  if self.options.sources.vimtex.enabled == true then
    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost' }, {
      group = self.augroup,
      desc = 'Update wordcount for TeX files',
      pattern = { '*.tex' },
      callback = function()
        self.wordcount = tostring(self.vimtex.wordcount())
      end,
    })
    return true
  end
  return false
end

function M.vimtex.wordcount(--[[ self ]]_, --[[ visual ]]_)
  -- TODO: figure out how to do ranges
  return vim.fn['vimtex#misc#wordcount']()
end

-- vim
M.vim = {}
function M.vim.setup(--[[ self ]])
end

function M.vim.wordcount(--[[ self ]]_, visual)
  local data = vim.fn.wordcount()
  return visual and data.visual_words or data.words
end

-- visual
M.visual = {}
function M.visual.setup(--[[ self ]])
end

function M.visual.wordcount(self, visual)
  return self.vim.wordcount(self, visual)
end

function M:get_wordcount(visual)
  return self.vim.wordcount(self, visual)
end

function M:update_wordcount()
  if not intable(vim.opt.filetype:get(), self.options.sources.vimtex.filetypes) then
    self.wordcount = tostring(self:get_wordcount(false)) .. ' words'
  end
end

-- component
function M:init(options)
  M.super.init(self, options)
  self.options = vim.tbl_deep_extend('keep', self.options or {}, default_options)

  self.wordcount = ""
  self.changedtick = -1

  self.augroup = vim.api.nvim_create_augroup('lualine-wordcount', { clear = true })

  self.vim.setup(self)
  self.vimtex.setup(self)
  self.visual.setup(self)
end

function M:update_status()
  if not intable(vim.opt.filetype:get(), self.options.filetypes) then
    return ''
  end

  if inVisual() and self.options.sources.visual.enabled == true then
    return tostring(self.visual.wordcount(self, true))
  elseif self.changedtick ~= vim.b.changedtick then
    self:update_wordcount()
    self.changedtick = vim.b.changedtick
  end

  return self.wordcount
end

return M
