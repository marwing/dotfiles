local he_utils = require('heirline.utils')
local colors = require('user.setup.heirline.colors')

local M = {}

M.notify = require('user.utils').notify('Heirline Config')
M.notify_once = require('user.utils').notify_once('Heirline Config')

local function surroundf(component, sep)
  local lifted = {}

  -- everything that can update self before hl is called has to go here
  -- on_click should work over the extended component
  -- update and condition should apply to prevent errors and partially updated/shown components
  local tolift = { 'static', 'condition', 'update', 'init', 'on_click' }
  for _, comp in ipairs(tolift) do
    lifted[comp], component[comp] = component[comp], nil
  end

  local function swapped_hl(self)
    local hl = component.hl(self)
    if not hl then
      return hl
    end
    hl.fg, hl.bg = hl.bg, nil
    return hl
  end

  return vim.tbl_extend('error', lifted, {
    {
      hl = swapped_hl,
      provider = sep.left,
    },
    component,
    {
      hl = swapped_hl,
      provider = sep.right,
    },
  })
end

---Correctly surround a component with seperators, lifting out necessary parts to not leave empty seperators
---@param component table
---@param sep {left: string|nil, right: string|nil}
---@param color? string|number
function M.surround(component, sep, color)
  vim.validate {
    component = { component, 'table' },
    sep = { sep, 'table' },
    color = { color, { 'string', 'number' }, true },
  }

  component = he_utils.clone(component)

  if not (sep and (sep.left or sep.right)) then
    M.notify('utils.surround called without any seperators')
    return component
  end

  if not color and type(component.hl) == 'function' then
    return surroundf(component, sep)
  end

  color = color or (component.hl and component.hl.bg) or colors.bg1

  -- lift condition out of component to apply to seperators as well
  local condition = component.condition
  component.condition = nil

  return {
    condition = condition,
    -- he_utils.surround({ sep.left, sep.right }, color, component),
    {
      hl = { fg = color },
      provider = sep.left,
    },
    {
      hl = { bg = color },
      component,
    },
    {
      hl = { fg = color },
      provider = sep.right,
    },
  }
end

return M
