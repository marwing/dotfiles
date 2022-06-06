local conditions = require('heirline.conditions')
local colors = require('user.setup.heirline.colors')

local function condition()
  return conditions.buffer_matches {
    buftype = { 'terminal' },
  }
end

local meta = require('user.setup.heirline.components.meta')
local file = require('user.setup.heirline.components.file')
local mode = require('user.setup.heirline.components.mode')

local TerminalName = {
  provider = function()
    local tname, _ = vim.api.nvim_buf_get_name(0):gsub('.*:', '')
    return ' ' .. tname
  end,
  hl = { fg = colors.blue, bold = true },
}

local statusline = {
  condition = condition,
  mode,
  meta.align,
  -- file.position,
}
local winbar = {
  condition = condition,
  file.file_type,
  meta.align,
  TerminalName,
}

return {
  statusline = statusline,
  winbar = winbar,
}
