local M = require('lualine.component'):extend()

local default_options = {
  visual = true,
  integrations = {
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

local function integrationEnabled(integration)
  return integration == true
      or (integration.enabled == true and intable(vim.opt.filetype:get(), integration.filetypes))
end

-- retrieving wordcount
local function wordcount_vimtex()
  -- TODO: figure out how to do ranges
  return vim.fn['vimtex#misc#wordcount']()
end

local function wordcount_vim(visual)
  local data = vim.fn.wordcount()
  return visual and data.visual_words or data.words
end

function M:get_wordcount(visual)
  if integrationEnabled(self.options.integrations.vimtex)
      and vim.fn.exists("b:vimtex")
      -- vimtex wordcount makes visual selection extremely laggy
      -- for now just use vim's wordcount
      and not visual
  then
    return wordcount_vimtex()
  else
    return wordcount_vim(visual)
  end
end

-- component
function M:init(options)
  M.super.init(self, options)
  self.options = vim.tbl_deep_extend('keep', self.options or {}, default_options)

  self.wordcount = ""
  self.changedtick = -1
end

function M:update_status()
  if not intable(vim.opt.filetype:get(), self.options.filetypes) then
    return ''
  end

  if inVisual() and integrationEnabled(self.options.integrations.visual) then
    return tostring(self:get_wordcount(true))
  elseif self.changedtick ~= vim.b.changedtick then
    self.wordcount = tostring(self:get_wordcount(false)) .. ' words'
    self.changedtick = vim.b.changedtick
  end

  return self.wordcount
end

return M
